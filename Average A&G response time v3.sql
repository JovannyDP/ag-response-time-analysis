DECLARE @StartDate AS DATE = '2025-07-01'
DECLARE @EndDate AS DATE = '2025-07-31'
;

WITH Action1407 AS (
	SELECT
		act.SERVICE_ID,
		act.INITIAL_UBRN_ID,
		CAST(CONVERT(DATETIME, STUFF(STUFF(STUFF(STUFF(STUFF(ACTION_DT_TM, 13, 0, ':'), 11, 0, ':'), 9, 0, ' '), 7, 0, '-'), 5, 0, '-')) AS DATETIME) AS ActionDate_1407
		, ISNULL(srv.SERVICE_NAME, 'Not specified') AS [Service]
		, CAST(CONVERT(DATETIME, STUFF(STUFF(STUFF(STUFF(STUFF(act.ACTION_DT_TM, 13, 0, ':'), 11, 0, ':'), 9, 0, ' '), 7, 0, '-'), 5, 0, '-')) AS DATETIME) AS ACTION_DT_TM_1407
	FROM 
		eRS.dbo.UBRN_Action act
	Left Join 
		eRs.[dbo].[Service] srv
		On act.SERVICE_ID = srv.SERVICE_ID
	CROSS APPLY (
		SELECT CAST(CONVERT(DATETIME, 
			STUFF(STUFF(STUFF(STUFF(STUFF(act.ACTION_DT_TM, 13, 0, ':'), 
			11, 0, ':'), 9, 0, ' '), 7, 0, '-'), 5, 0, '-')) AS DATETIME) AS ActionDateTime
	) AS conv
	 
	WHERE 
		1=1
		AND ACTION_CD = '1407'
		AND PROVIDER_ORG_ID = 'RA2'
		AND CONVERT(DATE, conv.ActionDateTime) BETWEEN @StartDate AND @EndDate
),
Action1408 AS (
	SELECT
		act.SERVICE_ID,
		act.INITIAL_UBRN_ID,
		CAST(CONVERT(DATETIME, STUFF(STUFF(STUFF(STUFF(STUFF(ACTION_DT_TM, 13, 0, ':'), 11, 0, ':'), 9, 0, ' '), 7, 0, '-'), 5, 0, '-')) AS DATETIME) AS ActionDate_1408
		, ISNULL(srv.SERVICE_NAME, 'Not specified') AS [Service]
		, CAST(CONVERT(DATETIME, STUFF(STUFF(STUFF(STUFF(STUFF(act.ACTION_DT_TM, 13, 0, ':'), 11, 0, ':'), 9, 0, ' '), 7, 0, '-'), 5, 0, '-')) AS DATETIME) AS ACTION_DT_TM_1408
	FROM eRS.dbo.UBRN_Action act
	Left Join
		eRs.[dbo].[Service] srv
		On act.SERVICE_ID = srv.SERVICE_ID
	CROSS APPLY (
		SELECT CAST(CONVERT(DATETIME, 
			STUFF(STUFF(STUFF(STUFF(STUFF(act.ACTION_DT_TM, 13, 0, ':'), 
			11, 0, ':'), 9, 0, ' '), 7, 0, '-'), 5, 0, '-')) AS DATETIME) AS ActionDateTime
	) AS conv
	WHERE 
		1=1
		AND ACTION_CD = '1408'
		AND PROVIDER_ORG_ID = 'RA2'
		AND CONVERT(DATE, conv.ActionDateTime) BETWEEN @StartDate AND @EndDate
),
DateDiffs AS (
	SELECT
		a07.SERVICE_ID,
		DATEDIFF(DAY, a07.ActionDate_1407, a08.ActionDate_1408) AS DiffDays
		, a07.[Service]
		--, ACTION_DT_TM_1407
		--, ACTION_DT_TM_1408
		, ACTION_DT_TM_1407
		, ACTION_DT_TM_1408
	FROM 
		Action1407 a07
	JOIN 
		Action1408 a08
		ON a07.INITIAL_UBRN_ID = a08.INITIAL_UBRN_ID
	WHERE
		1=1
		AND a07.[Service] NOT LIKE '%restricted service%'
		AND a07.[Service] NOT IN (
			'USC - General Surgery - HPB - Royal Surrey NHS Foundation Trust -  RA2'
			,'USC - General Surgery - Upper GI - Royal Surrey NHS Foundation Trust -  RA2'
			,'USC - Gynaecology - Royal Surrey NHS Foundation Trust - RA2', 'USC - Haematology - Royal Surrey NHS Foundation Trust - RA2'
			,'USC - Head & Neck -Royal Surrey NHS Foundation Trust - RA2'
			,'USC - Neurology - Royal Surrey NHS Foundation Trust - RA2'
			,'USC - Non-Specific but Serious Symptoms - Royal Surrey NHS Foundation Trust - RA2'
			,'USC - Respiratory - Royal Surrey NHS Foundation Trust - RA2'
			,'USC - Urology - Royal Surrey NHS Foundation Trust - RA2', 'USC - Urology upgrades (restricted service) - Royal Surrey NHS Foundation Trust - RA2'
			,'USC - Gastroenterology / Hepatology - Royal Surrey NHS Foundation Trust - RA2'
			,'USC - General Surgery - Colorectal - Royal Surrey NHS Foundation Trust - RA2'
			,'Children & Adolescent - Ophthalmology (Consultant review) - Royal Surrey NHS Foundation Trust - RA2'
			,'Diabetic Medicine - DESMOND - Royal Surrey NHS Foundation Trust - RA2'
			,'Dietetics - Royal Surrey NHS Foundation Trust - RA2'
			,'Medical Examiners Office - Royal Surrey NHS Foundation Trust - RA2'
			,'MSK (restricted service) Orthopaedics-C Spinal(neck)-Service-Royal Surrey NHS Foundation Trust - RA2'
			,'MSK (restricted service) Orthopaedics-Foot and Ankle- Service-Royal Surrey NHS Foundation Trust -RA2'
			,'MSK (restricted service) Orthopaedics-Hand & Wrist-Service-Royal Surrey NHS Foundation Trust - RA2'
			,'MSK (restricted service) Orthopaedics-Hip-Service-Royal Surrey NHS Foundation Trust - RA2'
			,'MSK (restricted service) Orthopaedics-Knee-Service-Royal Surrey NHS Foundation Trust - RA2'
			,'MSK (restricted service) Orthopaedics-Shoulder-Service-Royal Surrey NHS Foundation Trust - RA2'
			,'MSK (restricted service) Orthopaedics-Spinal-Service-Royal Surrey NHS Foundation Trust-RA2'
			,'MSK Diagnostic (restricted service) - Royal Surrey NHS Foundation Trust - RA2'
			,'Neurophysiology - Nerve Conduction & EMG - Royal Surrey NHS Foundation Trust - RA2'
			,'Ophthalmology - Squint & Motility-Orthoptics (restricted service) - Haslemere Hospital - RA219'
			,'Ophthalmology - Squint & Motility-Orthoptics (restricted service) - Royal Surrey NHS FT - RA2'
			,'Orthopaedic - Elbow (restricted service) - Royal Surrey NHS Foundation Trust - RA2'
			,'Orthopaedic - Foot & Ankle (restricted service) - Royal Surrey NHS Foundation Trust- RA2'
			,'Orthopaedic - Hand and Wrist (restricted service) - Royal Surrey NHS Foundation Trust- RA2'
			,'Orthopaedic - Hip (restricted service) - General - Royal Surrey NHS Foundation Trust - RA2'
			,'Orthopaedic - Knee (restricted service) - General - Royal Surrey NHS Foundation Trust - RA2'
			,'Orthopaedic - Lumber Spine (restricted service) - Royal Surrey NHS Foundation Trust - RA2'
			,'Orthopaedic - Shoulder (restricted service)  - Royal Surrey NHS FT - RA2'
			,'Orthotics - Royal Surrey NHS Foundation Trust - RA2'
			,'Pain Management - General - Outpatients - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Female Health - Pelvic Floor Class - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Lower Limb - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Male & Female Health - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Neurological - Physiotherapy - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Paediatric - Physiotherapy - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Respiratory - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy - Spinal/Upper Limb - Royal Surrey NHS Foundation Trust - RA2'
			,'Physiotherapy Community - Lower Limb - Haslemere Community Hospital - RA219'
			,'Physiotherapy Community - Male & Female Pelvic Health - Cranleigh Village Hospital - RA212'
			,'Physiotherapy Community - Male & Female Pelvic Health - Haslemere Community Hospital - RA219'
			,'Physiotherapy Community - Paediatric - Physiotherapy - Cranleigh Village Hospital - RA212'
			,'Physiotherapy Community - Paediatric - Physiotherapy - Haslemere Community Hospital- RA219'
			,'Urology - General (restricted service) - Outpatients - Royal Surrey NHS Foundation Trust - RA2'
			,'Urology - One Stop Haematuria Clinic - Outpatients - Royal Surrey NHS Foundation Trust - RA2'
			,'Urology - Psychosexual Health - Outpatients - Royal Surrey NHS Foundation Trust - RA2'
			)
)

SELECT
	[Service],
	CAST(AVG(CAST(DiffDays AS FLOAT)) AS DECIMAL(10,2)) AS AvgDiffDays
FROM 
	DateDiffs 
GROUP BY 
	[Service]
ORDER BY 
	[Service];



/*
SELECT	*
From		eRS.dbo.UBRN_Action act

Left Join	[eRs].dbo.CodifiedFields Specialties 
			On act.SPECIALTY_CD = Specialties.CODE And Specialties.USAGE = 'Specialty'
Left Join	eRs.[dbo].[Service] [Service]
			On act.SERVICE_ID = [Service].SERVICE_ID
WHERE
	1=1
	AND PATIENT_ID = '202442201'
	AND ACTION_CD IN ('1407' , '1408')
*/