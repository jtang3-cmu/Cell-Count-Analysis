-- =========================
-- Query
-- =========================

-- Question 3. Count patient number by each condition
SELECT s.condition, COUNT(DISTINCT s.patient_id) AS subject_count
FROM Samples s
GROUP BY s.condition;

-- Question 4. Query (condition == 'melanoma' or 'bladder cancer') and (sample_type == 'PBMC') and (time_from_treatment_start == 0)
SELECT s.*
FROM Samples s
WHERE s.condition IN ('melanoma', 'bladder cancer')
  AND s.sample_type = 'PBMC'
  AND s.time_from_treatment_start = 0
  AND s.treatment = 'tr1';

-- Question 5 (a). Grouped by each project
SELECT s.project_id, COUNT(*) AS sample_count
FROM Samples s
WHERE s.condition IN ('melanoma', 'bladder cancer')
  AND s.sample_type = 'PBMC'
  AND s.time_from_treatment_start = 0
  AND s.treatment = 'tr1'
GROUP BY s.project_id;

-- Question 5 (b). Grouped by response
SELECT s.response, COUNT(*) AS sample_count
FROM Samples s
WHERE s.condition IN ('melanoma', 'bladder cancer')
  AND s.sample_type = 'PBMC'
  AND s.time_from_treatment_start = 0
  AND s.treatment = 'tr1'
GROUP BY s.response;

-- Question 5 (c). Grouped by gender
SELECT p.gender, COUNT(DISTINCT s.patient_id) AS patient_count
FROM Samples s
JOIN Patients p ON s.patient_id = p.patient_id
WHERE s.condition IN ('melanoma', 'bladder cancer')
  AND s.sample_type = 'PBMC'
  AND s.time_from_treatment_start = 0
  AND s.treatment = 'tr1'
GROUP BY p.gender;
