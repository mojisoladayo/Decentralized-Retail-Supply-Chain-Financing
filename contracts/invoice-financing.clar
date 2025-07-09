;; Invoice Financing Contract
;; Manages invoice financing for suppliers

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u300))
(define-constant ERR_INVALID_INVOICE (err u301))
(define-constant ERR_INSUFFICIENT_FUNDS (err u302))
(define-constant ERR_ALREADY_FINANCED (err u303))
(define-constant ERR_NOT_FOUND (err u304))

;; Data structures
(define-map invoices
  { invoice-id: uint }
  {
    supplier-id: principal,
    retailer-id: principal,
    invoice-amount: uint,
    due-date: uint,
    created-date: uint,
    status: (string-ascii 20)
  }
)

(define-map financing-requests
  { invoice-id: uint }
  {
    requested-amount: uint,
    interest-rate: uint,
    financing-date: uint,
    repayment-date: uint,
    status: (string-ascii 20)
  }
)

(define-data-var next-invoice-id uint u1)
(define-data-var contract-balance uint u0)

;; Public functions
(define-public (create-invoice (retailer-id principal) (invoice-amount uint) (due-date uint))
  (let ((invoice-id (var-get next-invoice-id))
        (invoice-data {
          supplier-id: tx-sender,
          retailer-id: retailer-id,
          invoice-amount: invoice-amount,
          due-date: due-date,
          created-date: block-height,
          status: "pending"
        }))
    (begin
      (map-set invoices { invoice-id: invoice-id } invoice-data)
      (var-set next-invoice-id (+ invoice-id u1))
      (ok invoice-id))))

(define-public (request-financing (invoice-id uint) (requested-amount uint) (interest-rate uint))
  (match (map-get? invoices { invoice-id: invoice-id })
    invoice-info
    (if (is-eq (get supplier-id invoice-info) tx-sender)
      (let ((financing-data {
        requested-amount: requested-amount,
        interest-rate: interest-rate,
        financing-date: block-height,
        repayment-date: (+ block-height u1000),
        status: "requested"
      }))
        (if (is-none (map-get? financing-requests { invoice-id: invoice-id }))
          (begin
            (map-set financing-requests { invoice-id: invoice-id } financing-data)
            (ok true))
          ERR_ALREADY_FINANCED))
      ERR_UNAUTHORIZED)
    ERR_NOT_FOUND))

(define-public (approve-financing (invoice-id uint))
  (if (is-eq tx-sender CONTRACT_OWNER)
    (match (map-get? financing-requests { invoice-id: invoice-id })
      financing-info
      (begin
        (map-set financing-requests
          { invoice-id: invoice-id }
          (merge financing-info { status: "approved" }))
        (ok true))
      ERR_NOT_FOUND)
    ERR_UNAUTHORIZED))

;; Read-only functions
(define-read-only (get-invoice-info (invoice-id uint))
  (map-get? invoices { invoice-id: invoice-id }))

(define-read-only (get-financing-info (invoice-id uint))
  (map-get? financing-requests { invoice-id: invoice-id }))
