usersCREATE DATABASE wallet_system;
USE wallet_system;

-- 1. USERS (giả lập)
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name NVARCHAR(100) NOT NULL
);

-- 2. WALLETS (mỗi user 1 ví)
CREATE TABLE wallets (
    wallet_id INT AUTO_INCREMENT PRIMARY KEY,
    
    user_id INT NOT NULL UNIQUE,  -- mỗi user chỉ có 1 ví
    
    balance DECIMAL(15,2) NOT NULL DEFAULT 0 
        CHECK (balance >= 0),  -- không âm
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_wallet_user
    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
    
);

-- 3. TRANSACTIONS (lịch sử biến động)
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    
    wallet_id INT NOT NULL,
    
    transaction_type VARCHAR(20) NOT NULL 
        CHECK (transaction_type IN ('DEPOSIT', 'WITHDRAW', 'PAYMENT')),
    
    amount DECIMAL(15,2) NOT NULL 
        CHECK (amount > 0),
    
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING'
        CHECK (status IN ('PENDING', 'SUCCESS', 'FAILED')),
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_tx_wallet
    FOREIGN KEY (wallet_id)
    REFERENCES wallets(wallet_id)
    
);

-- Sẽ có 3 kịch bản xảy ra :
-- Không nhập tên
-- Giao dịch âm
-- Thời gian không đúng chính xác
