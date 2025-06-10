# Decentralized Retail Supply Chain Financing

A comprehensive blockchain-based solution for retail supply chain financing built on the Stacks blockchain using Clarity smart contracts.

## Overview

This system provides a decentralized platform for managing retail supply chain financing, including retailer verification, supplier management, invoice financing, payment processing, and risk assessment.

## Architecture

The system consists of five main smart contracts:

### 1. Retailer Verification Contract (\`retailer-verification.clar\`)
- Validates and manages retail business registrations
- Handles verification status and credit scoring
- Provides retailer authentication for the platform

### 2. Supplier Management Contract (\`supplier-management.clar\`)
- Manages supplier registrations and profiles
- Establishes and tracks supplier-retailer relationships
- Maintains supplier ratings and performance metrics

### 3. Invoice Financing Contract (\`invoice-financing.clar\`)
- Creates and manages supplier invoices
- Handles financing requests and approvals
- Tracks invoice status and payment terms

### 4. Payment Processing Contract (\`payment-processing.clar\`)
- Processes payments between parties
- Manages account balances and fund transfers
- Handles deposits and withdrawals

### 5. Risk Assessment Contract (\`risk-assessment.clar\`)
- Evaluates financial risk profiles
- Calculates risk scores based on multiple factors
- Provides financing recommendations and interest rate calculations

## Features

- **Retailer Verification**: Secure registration and verification of retail businesses
- **Supplier Management**: Comprehensive supplier onboarding and relationship management
- **Invoice Financing**: Streamlined invoice creation and financing requests
- **Payment Processing**: Secure and transparent payment handling
- **Risk Assessment**: Automated risk evaluation and scoring
- **Decentralized**: No single point of failure or control
- **Transparent**: All transactions recorded on blockchain
- **Automated**: Smart contract-based business logic

## Getting Started

### Prerequisites

- Stacks blockchain node or access to testnet
- Clarity CLI for contract deployment
- Node.js for running tests

### Installation

1. Clone the repository
2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Deploy contracts to Stacks blockchain:
   \`\`\`bash
   clarinet deploy
   \`\`\`

### Testing

Run the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

## Usage

### For Retailers

1. Register your business using the retailer verification contract
2. Wait for verification and credit score assignment
3. Establish relationships with suppliers
4. Receive and process invoices

### For Suppliers

1. Register your company in the supplier management system
2. Establish relationships with verified retailers
3. Create invoices for delivered goods/services
4. Request financing for outstanding invoices

### For Financiers

1. Review financing requests and risk assessments
2. Approve or reject financing based on risk profiles
3. Set interest rates based on calculated risk scores
4. Monitor repayments and performance

## Contract Functions

### Retailer Verification
- \`register-retailer\`: Register a new retail business
- \`verify-retailer\`: Verify a retailer and assign credit score
- \`get-retailer-info\`: Retrieve retailer information
- \`is-verified-retailer\`: Check verification status

### Supplier Management
- \`register-supplier\`: Register a new supplier
- \`establish-relationship\`: Create supplier-retailer relationship
- \`update-supplier-rating\`: Update supplier performance rating
- \`get-supplier-info\`: Retrieve supplier information

### Invoice Financing
- \`create-invoice\`: Create a new invoice
- \`request-financing\`: Request financing for an invoice
- \`approve-financing\`: Approve a financing request
- \`get-invoice-info\`: Retrieve invoice details

### Payment Processing
- \`deposit-funds\`: Deposit funds to account
- \`process-payment\`: Process payment between accounts
- \`withdraw-funds\`: Withdraw funds from account
- \`get-balance\`: Check account balance

### Risk Assessment
- \`assess-risk\`: Evaluate entity risk profile
- \`get-financing-recommendation\`: Get financing recommendation
- \`calculate-interest-rate\`: Calculate risk-based interest rate
- \`get-risk-profile\`: Retrieve risk assessment details

## Security Considerations

- All contracts include proper authorization checks
- Fund transfers are protected against insufficient balance scenarios
- Risk assessments prevent over-leveraging
- Contract ownership is clearly defined and protected

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the GitHub repository.
\`\`\`

Finally, let's create the PR details file:
