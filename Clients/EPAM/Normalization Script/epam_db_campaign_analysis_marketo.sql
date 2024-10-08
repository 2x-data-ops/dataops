TRUNCATE TABLE `x-marketing.epam.db_campaign_analysis_marketo`;

INSERT INTO `x-marketing.epam.db_campaign_analysis_marketo` (
    _sdc_sequence,
    _primary_attribute_name,
    _campaignID,
    _timestamp,
    _dayofweek,
    _prospectID,
    _url_link,
    _engagement,
    _isBot,
    _utm_source,
    _utm_medium,
    _subject,
    _description,
    _campaignSentDate,
    _screenshot,
    _landingpage,
    _email,
    _name,
    _title,
    _seniority,
    _phone,
    _company,
    _industry,
    _city,
    _state,
    _country,
    _region,
    _leadcreatedDate,
    _leadqualification,
    _leadstatus,
    _industrypreference,
    _personsource,
    _segment,
    _requestername,
    _branding,
    _partnermarketing,
    _marketingmanager,
    _industrybusinesstopic,
    _contenttype
)
  
WITH  seniority AS (
    SELECT "Assistant to" AS title, "Non-Manager" AS seniority UNION ALL 
    SELECT "Senior Counsel", "VP" UNION ALL
    SELECT "Assistant General Counsel", "VP" UNION ALL
    SELECT "General Counsel", "C-Level" UNION ALL
    SELECT "Founder", "C-Level" UNION ALL
    SELECT "C-Level", "C-Level" UNION ALL
    SELECT "CDO", "C-Level" UNION ALL
    SELECT "CIO", "C-Level" UNION ALL
    SELECT "CMO", "C-Level" UNION ALL
    SELECT "CFO", "C-Level" UNION ALL
    SELECT "CEO", "C-Level" UNION ALL
    SELECT "Chief", "C-Level" UNION ALL
    SELECT "coordinator", "Non-Manager" UNION ALL
    SELECT "COO", "C-Level" UNION ALL
    SELECT "Sr. V.P.", "Senior VP" UNION ALL
    SELECT "Sr.VP", "Senior VP" UNION ALL
    SELECT "Senior-Vice Pres", "Senior VP" UNION ALL
    SELECT "srvp", "Senior VP" UNION ALL
    SELECT "Senior VP", "Senior VP" UNION ALL
    SELECT "SR VP", "Senior VP" UNION ALL
    SELECT "Sr Vice Pres", "Senior VP" UNION ALL
    SELECT "Sr. VP", "Senior VP" UNION ALL
    SELECT "Sr. Vice Pres", "Senior VP" UNION ALL
    SELECT "S.V.P", "Senior VP" UNION ALL
    SELECT "Senior Vice Pres", "Senior VP" UNION ALL
    SELECT "Exec Vice Pres", "Senior VP" UNION ALL
    SELECT "Exec Vp", "Senior VP" UNION ALL
    SELECT "Executive VP", "Senior VP" UNION ALL
    SELECT "Exec VP", "Senior VP" UNION ALL
    SELECT "Executive Vice President", "Senior VP" UNION ALL
    SELECT "EVP", "Senior VP" UNION ALL
    SELECT "E.V.P", "Senior VP" UNION ALL
    SELECT "SVP", "Senior VP" UNION ALL
    SELECT "V.P", "VP" UNION ALL
    SELECT "VP", "VP" UNION ALL
    SELECT "Vice Pres", "VP" UNION ALL
    SELECT "V P", "VP" UNION ALL
    SELECT "President", "C-Level" UNION ALL
    SELECT "Director", "Director" UNION ALL
    SELECT "CTO", "C-Level" UNION ALL
    SELECT "Dir", "Director" UNION ALL
    SELECT "Dir.", "Director" UNION ALL
    SELECT "MDR", "Non-Manager" UNION ALL
    SELECT "MD", "Director" UNION ALL
    SELECT "GM", "Director" UNION ALL
    SELECT "Head", "VP" UNION ALL
    SELECT "Manager", "Manager" UNION ALL
    SELECT "escrow", "Non-Manager" UNION ALL
    SELECT "cross", "Non-Manager" UNION ALL
    SELECT "crosse", "Non-Manager" UNION ALL
    SELECT "Partner", "C-Level" UNION ALL
    SELECT "CRO", "C-Level" UNION ALL
    SELECT "Chairman", "C-Level" UNION ALL
    SELECT "Owner", "C-Level"
),prospect_info AS (
SELECT * EXCEPT (rownum) FROM (
      SELECT 
        CAST(marketo.id AS STRING) AS _leadid,
        marketo.email AS _email,
        CONCAT(marketo.firstname,' ', marketo.lastname) AS _name,
        marketo.title,
        CASE   WHEN LOWER(marketo.title) LIKE LOWER("%Senior Partner Marketing Manager%") THEN "Manager"
        WHEN LOWER(marketo.title) LIKE LOWER("%Principal Marketing Manager, Strategic Partnerships%") THEN "Manager"
        WHEN LOWER(marketo.title) LIKE LOWER("%Head of Channel Success%") THEN "Manager"
        WHEN LOWER(marketo.title) LIKE LOWER("%Channel Partnerships Manager%") THEN "Manager"
        WHEN LOWER(marketo.title) LIKE LOWER("%Partner Marketing Program Manager%") THEN "Manager"
        WHEN LOWER(marketo.title) LIKE LOWER("%COO%") THEN "C-Level"
        WHEN LOWER(marketo.title) LIKE LOWER("%CEO%") THEN "C-Level"
        WHEN LOWER(marketo.title) LIKE LOWER("%Vice President%") THEN "VP"
        WHEN LOWER(marketo.title) LIKE LOWER("%VP%") THEN "VP"
        WHEN LOWER(marketo.title) LIKE LOWER("%Sr marketing manager%") THEN "Manager"
        WHEN LOWER(marketo.title) LIKE LOWER("%Senior%") THEN "Other"
        WHEN LOWER(marketo.title) LIKE LOWER("%Staff%") THEN "Other"
       WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Senior Partner Marketing Manager%") THEN "Manager"
       WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Principal Marketing Manager%") THEN "Manager"
       WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Strategic Partnerships%") THEN "Manager"
       WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Partner Marketing Program Manager%") THEN "Manager"
       WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Channel Partnerships Manager%") THEN "Manager"
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Assistant to%") THEN "Non-Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Senior Counsel%") THEN "VP"  
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%General Counsel%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Founder%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%C-Level%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CDO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CIO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CMO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CFO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CEO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Chief%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%coordinator%") THEN "Non-Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%COO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Sr. V.P.%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Sr.VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Senior-Vice Pres%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%srvp%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Senior VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%SR VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Sr Vice Pres%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Sr. VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Sr. Vice Pres%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%S.V.P%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Senior Vice Pres%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Exec Vice Pres%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Exec Vp%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Executive VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Exec VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Executive Vice President%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%EVP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%E.V.P%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%SVP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%V.P%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Vice President%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Vice Pres%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%V P%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%VP%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%President%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Director%") THEN "Director" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CTO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Dir%") THEN "Director" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Dir.%") THEN "Director" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%MDR%") THEN "Non-Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%MD%") THEN "Director" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%GM%") THEN "Director" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Head%") THEN "VP" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Manager%") THEN "Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%escrow%") THEN "Non-Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%cross%") THEN "Non-Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%crosse%") THEN "Non-Manager" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Partner%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%CRO%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Chairman%") THEN "C-Level" 
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Owner%") THEN "C-Level"
         WHEN marketo.title IS NULL AND LOWER(marketo.title) LIKE LOWER("%Team Lead%") THEN "Manager"
        ELSE marketo.title END AS _seniority,
        marketo.phone,
        marketo.company,
        CASE WHEN LOWER(marketo.industry) = 'Retail' THEN 'Consumer'
        WHEN LOWER(marketo.industry) = 'Information Technology' THEN 'Software & Hi-Tech'
        WHEN LOWER(marketo.industry) = 'MACH' THEN 'Software & Hi-Tech'
        WHEN LOWER(marketo.industry) = 'Automotive' THEN 'Industrial'
        ELSE marketo.industry END AS industry,
        marketo.city,
        marketo.state,
        CASE WHEN marketo.country = 'Unknown value' THEN 'Other'
        WHEN marketo.country LIKE '%US%' OR marketo.country LIKE '%USA%' THEN 'United States' 
        WHEN marketo.country LIKE '%UK%' THEN 'United Kingdom'
        WHEN marketo.country LIKE '%South Korea%' THEN 'Korea, Republic of' ELSE marketo.country END AS country,
        c.region,
        createdat,
        CASE WHEN LOWER(title) LIKE '%journalist%' OR LOWER(title) LIKE '%reporter%' OR LOWER(title) LIKE 'student' OR LOWER(title) LIKE 'students' OR LOWER(title) LIKE 'studentin' OR LOWER(title) LIKE 'grad student' OR LOWER(title) LIKE 'master student' OR LOWER(title) LIKE 'intern' OR LOWER(title) LIKE 'mba intern' OR LOWER(title) LIKE 'machine learning intern' OR LOWER (title) LIKE '%publication%' OR LOWER(title) LIKE 'freelance' THEN 'Disqualified Leads' ELSE 'Qualified Leads'  END AS _leadqualification,
        leadsource,
        industrypreference,
        l._personsource,
        ROW_NUMBER() OVER( PARTITION BY CAST(marketo.id AS STRING) ORDER BY createdat DESC) AS rownum
    FROM `x-marketing.epam_marketo.leads` marketo
    LEFT JOIN `x-marketing.epam.db_country` c ON marketo.country = c.country
    LEFT JOIN `x-marketing.epam_mysql.epam_db_customfields_lead` l ON l._leadid = CAST(marketo.id AS STRING)
    WHERE 
        marketo.email  NOT LIKE '%@2x.marketing%' AND marketo.email NOT LIKE '%2X%' AND marketo.email NOT LIKE '%@epam.com' AND marketo.email NOT LIKE 'skylarulry@yahoo.com' AND marketo.email NOT LIKE '%test%' AND marketo.email <> 'sonam.gupta@capgemini.com'
        AND (emailinvalid IS FALSE OR unsubscribed IS FALSE)
        )
        WHERE rownum = 1
),sent_email AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp,
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek,
            CAST( activity.leadid AS STRING) AS _leadid, 
            email AS _email,
            campaign._campaignname AS _description,
            '' as _url_link,
            'Sent' AS _engagement,
            CAST(null AS String) AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_send_email` activity 
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid
        LEFT JOIN `x-marketing.epam_marketo.activities_delete_lead` d ON d.leadid = activity.leadid
        WHERE l.email NOT LIKE '%@2x.marketing%'
        AND d.leadid IS NULL
  ) 
WHERE rownum = 1

),delivered_email AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp, 
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek,
            CAST( activity.leadid AS STRING) AS _leadid, 
            email AS _email,
            campaign._campaignname AS _description,
            '' as _url_link,
            'Delivered' AS _engagement,
            CAST(null AS String)  AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_email_delivered` activity 
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid
        WHERE l.email NOT LIKE '%@2x.marketing%'
    ) 
    WHERE rownum = 1

),open_email AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp, 
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek,
            CAST( activity.leadid AS STRING) AS _leadid, 
            email AS _email,
            CASE WHEN activity.primary_attribute_value = 'Ecosystem Education Webinar Email 2.Email 2' THEN 'Ecosystem Email 2.Email 2' 
            WHEN activity.primary_attribute_value = 'Ecosystem Education Webinar Email 1.Email 1' THEN 'Ecosystem Email 1.Email 1' 
            ELSE campaign._campaignname END AS _description, 
            '' as _url_link,
            'Opened' AS _engagement,
            CAST(is_bot_activity AS STRING) AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_open_email` activity
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid  
        LEFT JOIN `x-marketing.epam_marketo.activities_delete_lead` d ON d.leadid = activity.leadid  
        WHERE l.email NOT LIKE '%@2x.marketing%'
        AND d.leadid IS NULL
    ) 
    WHERE rownum = 1

),clicked_email AS (
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp, 
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek,
            CAST( activity.leadid AS STRING) AS _leadid, 
            email AS _email,
            campaign._campaignname AS _description, 
            activity.link as _url_link,
            'Clicked' AS _engagement,
            CAST(is_bot_activity AS STRING) AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_click_email` activity 
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid
        LEFT JOIN `x-marketing.epam_marketo.activities_delete_lead` d ON d.leadid = activity.leadid
        WHERE CAST(is_bot_activity AS STRING) = 'false' 
        --AND activity.link NOT LIKE '%iclick%'
        AND l.email NOT LIKE '%@2x.marketing%'
        AND d.leadid IS NULL
        AND activity._sdc_sequence <> 1697681411029821012

),
unique_click AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT * FROM clicked_email
   ) WHERE rownum = 1
),
iclick_history AS (
    SELECT * EXCEPT(rownum)
    FROM clicked_email
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11
    HAVING COUNTIF (_url_link NOT LIKE '%iclick%') = 0
),
total_click AS (
    SELECT * FROM unique_click
    WHERE _leadid NOT IN (
      SELECT _leadid FROM iclick_history
    )
    /* SELECT * EXCEPT (rn) 
    FROM (
        SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY campaignID, _leadid, _email ORDER BY _timestamp DESC) AS rn
  FROM unique_click
  WHERE _leadid NOT IN (
    SELECT _leadid FROM no_iclick
  )
    ) 
    WHERE rn = 1 */  -- Option to remove the duplicate for special case
),
open_click AS ( --merge open and click data
    SELECT * FROM open_email
    UNION ALL
    SELECT * FROM total_click

), new_open AS ( --to populate the data in Clicked but not appear in Opened list
    SELECT * EXCEPT (rownum)
    FROM (SELECT * EXCEPT (_engagement,_isBot), 
    'Opened' AS _engagement, 
    CAST(_isBot AS STRING) AS _isBot,
    ROW_NUMBER() OVER (PARTITION BY _leadid,_description ORDER BY _timestamp DESC) AS rownum
    FROM open_click
    WHERE _engagement <> 'Opened' AND _engagement = 'Clicked')
    WHERE rownum = 1

), total_open AS ( --remove duplicate between the Clicked and Opened list data
    SELECT * EXCEPT (rownum)
    FROM (
    SELECT open.*, ROW_NUMBER() OVER (PARTITION BY _leadid,_description ORDER BY _timestamp DESC) AS rownum FROM (
        SELECT * FROM open_email
        UNION ALL
        SELECT * FROM new_open
    ) open
    )
    WHERE rownum = 1

), 
unsubscribed_email AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp, 
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek,
            CAST( activity.leadid AS STRING) AS _leadid, 
            email AS _email,
            campaign._campaignname AS _description, 
            activity.referrer_url as _url_link,
            'Unsubscribed' AS _engagement,
            CAST(null AS String) AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_unsubscribe_email` activity
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid 
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid
        LEFT JOIN `x-marketing.epam_marketo.activities_delete_lead` d ON d.leadid = activity.leadid
        WHERE l.email NOT LIKE '%@2x.marketing%'
        AND d.leadid IS NULL
    ) 
    WHERE rownum = 1

),bounced_email AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp,
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek, 
            CAST( activity.leadid AS STRING) AS _leadid,
            l.email AS _email,
            campaign._campaignname AS _description,
            activity.details as _url_link,
            'Bounced' AS _engagement,
            CAST(null AS String) AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_email_bounced` activity 
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid
    ) 
    WHERE rownum = 1

),soft_bounced_email AS (
    SELECT * EXCEPT(rownum) 
    FROM ( 
        SELECT
            activity._sdc_sequence,
            activity.primary_attribute_name,
            CAST(activity.primary_attribute_value_id AS STRING) AS campaignID,
            activity.activitydate AS _timestamp, 
            EXTRACT(DAYOFWEEK FROM activity.activitydate) AS _dayofweek,
            CAST( activity.leadid AS STRING) AS _leadid, 
            l.email AS _email,
            campaign._campaignname AS _description, 
            '' AS _url_link,
            'Soft Bounced' AS _engagement,
            CAST(null AS String) AS _isBot,
            ROW_NUMBER() OVER( PARTITION BY activity.leadid,activity.primary_attribute_value ORDER BY activity.activitydate DESC) AS rownum
        FROM `x-marketing.epam_marketo.activities_email_bounced_soft` activity 
        JOIN `x-marketing.epam_mysql.epam_db_airtable_email` campaign ON activity.primary_attribute_value_id =campaign._pardotid
        JOIN `x-marketing.epam_marketo.leads` l ON l.id = activity.leadid
    ) 
    WHERE rownum = 1
),

soft_hard_email AS ( --merge soft and hard bounced
    SELECT *
    FROM (
        SELECT * FROM bounced_email
        UNION ALL
        SELECT * FROM soft_bounced_email
    )
),

new_delivered_email AS( --remove soft and hard bounced in delivered list
    SELECT d.*
    FROM delivered_email d
    LEFT JOIN soft_hard_email b ON d.campaignID = b.campaignID AND d._leadid = b._leadid
    WHERE b.campaignID IS NULL AND b._leadid IS NULL
),

overall_delivered AS ( --delivered based on current smart list
    SELECT n.* FROM new_delivered_email n
LEFT JOIN `x-marketing.epam_marketo.activities_delete_lead` d ON CAST(d.leadid AS STRING) = _leadid
WHERE d.leadid IS NULL

),
missing_delivered AS (
    SELECT
        open._sdc_sequence,
        open.primary_attribute_name,
        open.campaignID,
        open._timestamp,
        open._dayofweek,
        open._leadid,
        open._email,
        open._description,
        open._url_link,
        'Delivered' AS _engagement,
        open._isBot
    FROM total_open open
    --open_email open
    LEFT JOIN overall_delivered delivered
    ON open._leadid = delivered._leadid
    AND open.campaignID = delivered.campaignID
    WHERE delivered._leadid IS NULL
    AND delivered.campaignID IS NULL
),
all_delivered AS (
    SELECT * FROM overall_delivered
    UNION ALL 
    SELECT * FROM missing_delivered
),
asset_info AS (
    SELECT *
    FROM `x-marketing.epam_mysql.epam_db_airtable_email`

)
SELECT engagements.* EXCEPT (_description,_email),
    asset_info._utm_source,
    asset_info._utm_medium,
    asset_info._subject, 
    asset_info._campaignname,
    CASE WHEN LENGTH(asset_info._livedate) > 0 
         THEN CAST(asset_info._livedate AS TIMESTAMP)
         ELSE NULL END AS _campaignSentDate,
    asset_info._screenshot, 
    asset_info._landingpage,
    prospect_info.* EXCEPT (_leadid),
    asset_info._segment,
    asset_info._requestername,
    asset_info._branding,
    CASE WHEN region = 'EMEA' AND asset_info._campaignname LIKE '%Adobe%' THEN 'April Leatherman' 
    WHEN region = 'NA' AND asset_info._campaignname LIKE '%Adobe%' THEN 'Kiley Groves'
    WHEN region = 'Nordics' AND asset_info._campaignname LIKE '%Adobe%' THEN 'April Leatherman'
    WHEN region = 'UKI' AND asset_info._campaignname LIKE '%Adobe%' THEN 'April Leatherman'
    WHEN region = 'MENA' AND asset_info._campaignname LIKE '%Adobe%' THEN 'TBD'
    WHEN region = 'NA' AND asset_info._campaignname LIKE '%Sitecore%' THEN 'Ellen Waugh'
    WHEN region = 'EMEA' AND asset_info._campaignname LIKE '%Sitecore%' THEN 'Victoria Smith'
    WHEN region = 'MENA' AND asset_info._campaignname LIKE '%Sitecore%' THEN 'TBD' ELSE NULL END AS _partnermarketing,
    asset_info._marketingManager,
    asset_info._industrybusinesstopic,
    asset_info._contenttype
FROM (
    SELECT * FROM all_delivered
    UNION ALL
    SELECT * FROM total_open
    UNION ALL
    SELECT * FROM total_click
    UNION ALL
    SELECT * FROM sent_email 
    UNION ALL 
    SELECT * FROM unsubscribed_email
    UNION ALL
    SELECT * FROM bounced_email
    UNION ALL
    SELECT * FROM soft_bounced_email
) AS engagements
LEFT JOIN asset_info ON engagements.campaignID = asset_info._pardotid
LEFT JOIN prospect_info ON LOWER(engagements._leadid) = LOWER(prospect_info._leadid);




--- Label Bots
UPDATE `x-marketing.epam.db_campaign_analysis_marketo` origin  
SET origin._isBot = 'Yes'
FROM (
    SELECT
        CASE WHEN TIMESTAMP_DIFF(click._timestamp, open._timestamp, SECOND) <= 2 THEN click._email 
        ELSE NULL 
        END AS _email, 
        click._utm_campaign 
    FROM `x-marketing.epam.db_campaign_analysis_marketo` AS click
    JOIN `x-marketing.epam.db_campaign_analysis_marketo` AS open ON LOWER(click._email) = LOWER(open._email)
    AND click._utm_campaign = open._utm_campaign
    WHERE click._engagement = 'Clicked'AND open._engagement = 'Opened'
    EXCEPT DISTINCT
    SELECT 
        conversion._email, 
        conversion._utm_campaign
    FROM `x-marketing.epam.db_campaign_analysis_marketo` AS conversion
    WHERE conversion._engagement IN ('Downloaded')
) bot
WHERE 
    origin._email = bot._email
AND origin._utm_campaign = bot._utm_campaign
AND origin._engagement IN ('Clicked','Opened');

--- Set Show Export
UPDATE `x-marketing.epam.db_campaign_analysis_marketo` origin
SET origin._showExport = 'Yes'
FROM (
    WITH focused_engagement AS (
        SELECT 
            _email, 
            _engagement, 
            _description,
            CASE WHEN _engagement = 'Opened' THEN 1
                WHEN _engagement = 'Clicked' THEN 2
                WHEN _engagement IN ( 'Downloaded') THEN 3
            END AS _priority
        FROM `x-marketing.epam.db_campaign_analysis_marketo`
        WHERE _engagement IN('Opened', 'Clicked', 'Downloaded')
        ORDER BY 1, 3, 4 DESC 
    ),
    final_engagement AS (
        SELECT * EXCEPT(_priority, _rownum)
        FROM (
            SELECT *, ROW_NUMBER() OVER(PARTITION BY _email, _description ORDER BY _priority DESC) AS _rownum
            FROM focused_engagement
        )
        WHERE _rownum = 1
    )    
    SELECT * FROM final_engagement
) AS final
WHERE origin._email = final._email
AND origin._engagement = final._engagement
AND origin._description = final._description;

--false delivered
UPDATE `x-marketing.epam.db_campaign_analysis_marketo` origin
SET origin._falseDelivered = 'True'
FROM (

      SELECT 
        _email,
        _engagement,
        _description,
        _hasDelivered,_hasBounced
    FROM (
        SELECT 
            _email,
            _engagement,
            _description,
            SUM(CASE WHEN _engagement = 'Delivered' THEN 1 END) AS _hasDelivered,
            SUM(CASE WHEN _engagement = 'Bounced' THEN 1 END) AS _hasBounced,
            SUM(CASE WHEN _engagement = 'Soft Bounced' THEN 1 END) AS _hasSoftBounced
        FROM 
            `x-marketing.epam.db_campaign_analysis_marketo`
        WHERE
            _engagement IN ('Delivered', 'Bounced', 'Soft Bounced')
        GROUP BY
            1, 2, 3
    )
    WHERE 
        _hasDelivered IS NOT NULL
    AND (_hasBounced IS NOT NULL OR _hasSoftBounced IS NOT NULL)
) scenario
WHERE
    origin._email = scenario._email
AND origin._description = scenario._description
AND origin._engagement IN ( 'Delivered');




--leads dashboard
CREATE OR REPLACE TABLE `x-marketing.epam.db_leads` AS 
WITH leads AS (
    SELECT leads.*, 
    CASE WHEN LOWER(title) LIKE '%journalist%' OR LOWER(title) LIKE '%reporter%' OR LOWER(title) LIKE 'student' OR LOWER(title) LIKE 'students' OR LOWER(title) LIKE 'studentin' OR LOWER(title) LIKE 'grad student' OR LOWER(title) LIKE 'master student' OR LOWER(title) LIKE 'intern' OR LOWER(title) LIKE 'mba intern' OR LOWER(title) LIKE 'machine learning intern' OR LOWER (title) LIKE '%publication%' OR LOWER(title) LIKE 'freelance' THEN 'Disqualified Leads' ELSE 'Qualified Leads' END AS _leadqualification, 
    program.name, 
    program.channel, 
    program.type, 
    program.workspace, 
    competitor.classification,
    c.region,
    l._personsource
FROM `x-marketing.epam_marketo.leads` leads
LEFT JOIN `x-marketing.epam_marketo.programs` program ON leads.acquisitionprogramid = CAST(program.id AS STRING)
LEFT JOIN `x-marketing.epam_google_sheets.partner_competitor` competitor ON LOWER(competitor.competitors) = LOWER(leads.company)
LEFT JOIN `x-marketing.epam.db_country` c ON leads.country = c.country
LEFT JOIN `x-marketing.epam_mysql.epam_db_customfields_lead` l ON l._leadid = CAST(leads.id AS STRING)
),
email_lead AS (
SELECT * FROM `x-marketing.epam.db_campaign_analysis_marketo` email WHERE _engagement = 'Delivered'
)
SELECT 
    leads.*,
    email_lead._description,
    email_lead._segment,
    email_lead._contenttype,
    DATE_DIFF(CURRENT_DATE('Hongkong'),
    CAST(createdat AS DATE),DAY) as day_diff,
    email_lead._segment AS _email_segment
FROM leads
JOIN email_lead ON email_lead._prospectID = CAST(leads.id AS STRING);


--cold and warm leads (database page)
CREATE OR REPLACE TABLE `x-marketing.epam.db_leads_status` AS
WITH overall_lead AS (
SELECT 
    DISTINCT CAST(id AS STRING) AS _prospectID, 
    persontype, 
    leads.country, 
    company, 
    email, 
    industry,
    /*CASE WHEN LOWER(industry) = 'retail' THEN 'Consumer'
        WHEN LOWER(industry) = 'information technology' THEN 'Software & Hi-Tech'
        WHEN LOWER(industry) = 'mach' THEN 'Software & Hi-Tech'
        WHEN LOWER(industry) = 'automotive' THEN 'Industrial'
        WHEN LOWER(industry) = 'telecom media & entertainment' THEN 'Telecom, Media & Entertainment'
        ELSE industry END AS industry, */
    createdat, 
    mktoname, 
    phone,
    c.region,
    leadsource,
    industrypreference,
    _personsource,
    _seniority,
    _industrystandard,
    '' AS _segment, 
    title AS _title
FROM `x-marketing.epam_marketo.leads` leads
LEFT JOIN `x-marketing.epam.db_country` c ON leads.country = c.country
LEFT JOIN `x-marketing.epam_mysql.epam_db_customfields_lead` l ON l._leadid = CAST(id AS STRING)
WHERE  email  NOT LIKE '%@2x.marketing%' AND email NOT LIKE '%2X%' AND email NOT LIKE '%@epam.com' AND email NOT LIKE 'skylarulry@yahoo.com' AND email NOT LIKE '%test%' AND marketingsuspended IS false
),
warm_lead AS (
 SELECT 
    DISTINCT m._prospectID, 
    'Contact' AS persontype, 
    m._country, 
    m._company, 
    m._email, 
    m._industry,
    /*CASE WHEN LOWER(_industry) = 'retail' THEN 'Consumer'
        WHEN LOWER(_industry) = 'information technology' THEN 'Software & Hi-Tech'
        WHEN LOWER(_industry) = 'mach' THEN 'Software & Hi-Tech'
        WHEN LOWER(_industry) = 'automotive' THEN 'Industrial'
        WHEN LOWER(_industry) = 'telecom media & entertainment' THEN 'Telecom, Media & Entertainment'
        ELSE _industry END AS industry, */
    m._leadcreatedDate, 
    m._name, 
    m._phone,
    m._region,
    m._leadstatus, 
    m._industrypreference,
    m._personsource,
    l._seniority,
    l._industrystandard,
    m._segment,  
    m._title,
    m._campaignID, 
    m._engagement, 
    m._description,
    m._subject,
    'Warm' AS _type
 FROM `x-marketing.epam.db_campaign_analysis_marketo` m
 LEFT JOIN `x-marketing.epam_mysql.epam_db_customfields_lead` l ON l._leadid = m._prospectID
 WHERE _engagement NOT IN ('Sent','Soft Bounced','Bounced','Unsubscribed')
),
cold_lead AS (
    SELECT o.*,
    '' AS _campaignID,
    '' AS _engagement,
    '' AS _description,
    '' AS _subject,
    'Cold' AS contacttype
    FROM overall_lead o
    LEFT JOIN warm_lead w ON w._prospectID = o._prospectID
    WHERE w._prospectID IS NULL
)
SELECT a.* 
FROM (
  SELECT * FROM warm_lead
  UNION ALL
  SELECT * FROM cold_lead
) a
LEFT JOIN `x-marketing.epam_mysql.epam_db_ipqs_list` ipqs ON ipqs._prospectid = a._prospectID
WHERE ipqs._prospectid IS NULL
;


--account engagement
CREATE OR REPLACE TABLE epam.db_account_engagements AS 
WITH 
tam_contacts AS (
  SELECT * EXCEPT(_rownum) 
  FROM (
    SELECT DISTINCT
        id AS _leadorcontactid,
        persontype AS _contact_type,
        firstname AS _firstname, 
        lastname AS _lastname, 
        title AS _title, 
        NULL AS _2xseniority,
        email AS _email,
        CAST(NULL AS STRING) AS _accountid,
        RIGHT(email, LENGTH(email)-STRPOS(email,'@')) AS _domain, 
        company AS _accountname, 
        industry AS _industry, 
        /*COALESCE(_tier, CAST(NULL AS STRING))*/ NULL AS _tier, 
        --CAST(_revenue AS INTEGER) AS _annualrevenue,
        ROW_NUMBER() OVER(
            PARTITION BY email 
            ORDER BY prosp._sdc_received_at DESC
        ) _rownum
    FROM 
      `epam_marketo.leads` prosp
    
  )
  WHERE _rownum = 1
),
#Query to pull the email engagement 
email_engagement AS (
    SELECT * 
    FROM ( 
      SELECT _email, 
      RIGHT(_email,LENGTH(_email)-STRPOS(_email,'@')) AS _domain, 
      EXTRACT(DATETIME FROM _timestamp) AS _date , 
      EXTRACT(WEEK FROM _timestamp) AS _week,  
      EXTRACT(YEAR FROM _timestamp) AS _year,
      _description, 
      CONCAT("Email ", INITCAP(_engagement)) AS _engagement
      FROM 
        (SELECT * FROM `epam.db_campaign_analysis_marketo`)
      WHERE 
     LOWER(_engagement) NOT IN ('sent','delivered', 'bounced', 'unsubscribed')
    ) a
    WHERE 
      NOT REGEXP_CONTAINS(_domain,'2x.marketing|epam|gmail|yahoo|outlook|hotmail') 
      AND _domain IS NOT NULL
      --AND _year = 2022 AND _year = 2023
    ORDER BY 1, 3 DESC, 2 DESC
),
dummy_dates AS ( 
    SELECT _date,
    EXTRACT(WEEK FROM _date) AS _week,
    EXTRACT(YEAR FROM _date) AS _year
  FROM 
    UNNEST(GENERATE_DATE_ARRAY('2022-01-01', CURRENT_DATE(), INTERVAL 1 DAY)) AS _date 
),

contact_engagement AS (

  SELECT 
    DISTINCT 
    tam_contacts._domain, 
    tam_contacts._email,
    dummy_dates.*EXCEPT(_date), 
    engagements.*EXCEPT(_date, _week, _year, _domain, _email),
    tam_contacts.*EXCEPT(_domain, _email),
    engagements._date
  FROM 
    dummy_dates
  JOIN (
    SELECT * FROM email_engagement /*UNION ALL
    SELECT * FROM form_fills*/
  ) engagements USING(_week, _year)
  JOIN
    tam_contacts USING(_email) 
),
combined_engagements AS (
  SELECT * FROM contact_engagement
  --UNION DISTINCT
  --SELECT * FROM account_engagement
)
SELECT 
  DISTINCT
  _domain,
  _accountid,
  _date,
  SUM(IF(_engagement = 'Email Opened', 1, 0)) AS _emailOpens,
  SUM(IF(_engagement = 'Email Clicked', 1, 0)) AS _emailClicks,
  SUM(IF(_engagement = 'Email Downloaded', 1, 0)) AS _emailDownloads,
  SUM(IF(_engagement = 'Form Filled', 1, 0)) AS _gatedForms,
  SUM(IF(_engagement = 'Web Visit', 1, 0)) AS _webVisits,
  SUM(IF(_engagement = 'Ad Clicks', 1, 0)) AS _adClicks,
FROM 
  combined_engagements
GROUP BY 
  1, 2, 3
ORDER BY _date DESC
;