-- =========================
-- Database Schema
-- =========================

-- 1. Create Projects Table (store project information)
CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    description TEXT
);

-- 2. Create Patients Table (store patients information)
CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    subject_id VARCHAR(100) UNIQUE NOT NULL,
    gender VARCHAR(10),
    age INTEGER
);

-- 3. Create Samples Table (store samples information)
CREATE TABLE Samples (
    sample_id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES Patients(patient_id),
    project_id INTEGER REFERENCES Projects(project_id),
    treatment VARCHAR(50), -- 'tr1' or 'tr2'
    response CHAR(1),  -- 'y' for responder, 'n' for non-responder
    sample_type VARCHAR(50),  -- 'PBMC' or 'tumor'
    condition VARCHAR(50),  -- 'melanoma', 'healthy', 'lung'
    time_from_treatment_start INTEGER  -- 0 (baseline)
);

-- 4. Create CellCounts Table (store cell counts)
CREATE TABLE CellCounts (
    sample_id INTEGER REFERENCES Samples(sample_id),
    populations VARCHAR(50),  -- 'b_cell', 'cd8_t_cell', 'cd4_t_cell', 'nk_cell', 'monocyte'
    count INTEGER
);

-- ============================
-- Create Index For Query
-- ============================
CREATE INDEX idx_samples_condition ON Samples(condition);
CREATE INDEX idx_samples_treatment ON Samples(treatment);
CREATE INDEX idx_samples_response ON Samples(response);
CREATE INDEX idx_samples_time ON Samples(time_from_treatment_start);
