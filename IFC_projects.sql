-- Changing data type

UPDATE ifc_advisory_services_projects
SET DisclosureDate = STR_TO_DATE(DisclosureDate, '%b %d, %Y');
UPDATE ifc_advisory_services_projects
SET IFCApprovalDate = STR_TO_DATE(IFCApprovalDate, '%b %d, %Y');


WITH extr AS (
    SELECT 
        DisclosureDate,
        ProjectNumber,
        ProjectName,
        Country,
        IFCregion,
        BusinessLine,
        EstimatedTotalBudget,
        Status,
        IFCApprovalDate,
        DisclosureDate - IFCApprovalDate AS DDelta
    FROM 
        data_analysis.ifc_advisory_services_projects
    WHERE 
	DisclosureDate <> '0000-00-00' AND IFCApprovalDate <> '0000-00-00 ' AND EstimatedTotalBudget <> 0
)
SELECT distinct IFCregion FROM extr;


-- Renaming regions
UPDATE data_analysis.ifc_advisory_services_projects
SET IFCregion = CASE
    WHEN IFCregion = 'Eastern Africa' THEN 'Africa'
    WHEN IFCregion = 'Central Asia and Turkiye' THEN 'Central Asia'
    WHEN IFCregion = 'North Africa and Horn of Africa' THEN 'Africa'
    WHEN IFCregion = 'West Africa' THEN 'Africa'
    WHEN IFCregion = 'Southern Africa' THEN 'Africa'
    WHEN IFCregion = 'Central Africa, Liberia, Nigeria, and Sierra Leone' THEN 'Africa'
    WHEN IFCregion = 'Central America and the Caribbean, Colombia, Mexico' THEN 'Central America'
    WHEN IFCregion = 'Latin America and the Caribbean and Europe' THEN 'Latin America'
    ELSE IFCregion
END;

SELECT 
        DisclosureDate,
        ProjectNumber,
        ProjectName,
        Country,
        IFCregion,
        BusinessLine,
        EstimatedTotalBudget,
        Status,
        IFCApprovalDate,
        DisclosureDate - IFCApprovalDate AS DDelta
    FROM 
        data_analysis.ifc_advisory_services_projects
    WHERE 
	DisclosureDate <> '0000-00-00' AND IFCApprovalDate <> '0000-00-00 ' AND EstimatedTotalBudget <> 0;
