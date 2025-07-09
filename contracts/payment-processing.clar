;; Payment Processing Contract
;; Processes supply chain payments

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u400))
(define-constant ERR_INSUFFICIENT_FUNDS (err u401))
(define-constant ERR_INVALID_PAYMENT (err u402))
(define-constant ERR_PAYMENT_NOT_FOUND (err u403))

;; Data structures
(define-map payments
  { payment-id: uint }
  {
    payer-id: principal,
    payee-id: principal,
    amount: uint,
    payment-date: uint,
    payment-type: (string-ascii 50),
    status: (string-ascii 20),
    reference-id: uint
  }
)

(define-map account-balances
  { account-id: principal }
  { balance: uint }
)

(define-data-var next-payment-id uint u1)

;; Public functions
(define-public (deposit-funds (amount uint))
  (let ((current-balance (default-to u0 (get balance (map-get? account-balances { account-id: tx-sender })))))
    (begin
      (map-set account-balances
        { account-id: tx-sender }
        { balance: (+ current-balance amount) })
      (ok true))))

(define-public (process-payment (payee-id principal) (amount uint) (payment-type (string-ascii 50)) (reference-id uint))
  (let ((payer-balance (default-to u0 (get balance (map-get? account-balances { account-id: tx-sender }))))
        (payment-id (var-get next-payment-id)))
    (if (>= payer-balance amount)
      (let ((payee-balance (default-to u0 (get balance (map-get? account-balances { account-id: payee-id }))))
            (payment-data {
              payer-id: tx-sender,
              payee-id: payee-id,
              amount: amount,
              payment-date: block-height,
              payment-type: payment-type,
              status: "completed",
              reference-id: reference-id
            }))
        (begin
          (map-set account-balances
            { account-id: tx-sender }
            { balance: (- payer-balance amount) })
          (map-set account-balances
            { account-id: payee-id }
            { balance: (+ payee-balance amount) })
          (map-set payments { payment-id: payment-id } payment-data)
          (var-set next-payment-id (+ payment-id u1))
          (ok payment-id)))
      ERR_INSUFFICIENT_FUNDS)))

(define-public (withdraw-funds (amount uint))
  (let ((current-balance (default-to u0 (get balance (map-get? account-balances { account-id: tx-sender })))))
    (if (>= current-balance amount)
      (begin
        (map-set account-balances
          { account-id: tx-sender }
          { balance: (- current-balance amount) })
        (ok true))
      ERR_INSUFFICIENT_FUNDS)))

;; Read-only functions
(define-read-only (get-balance (account-id principal))
  (default-to u0 (get balance (map-get? account-balances { account-id: account-id }))))

(define-read-only (get-payment-info (payment-id uint))
  (map-get? payments { payment-id: payment-id }))
