CREATE OR REPLACE TABLE `x-marketing.sixsense.db_6sense_acc`
AS
WITH alldata AS (
    SELECT  *
        EXCEPT (_month, _sdc_received_at, _sdc_sequence, _sdc_table_version, _rownumber, _id, _batchid, _sdc_batched_at),
        account._month AS _month,
        opp._month AS month
    FROM x-marketing.sixsense_mysql.db_buying_stages account
    LEFT JOIN x-marketing.sixsense_mysql.db_influencing_opp opp
        ON CONCAT(account._6sensecompanyname, account._6sensedomain, account._6sensecountry) = CONCAT(opp._accountname, opp._accountwebsite, opp. _accountcountry)
        AND account._month = opp._month
)
SELECT *
EXCEPT (_accountname, _accountwebsite, _accountcountry, month)
FROM alldata