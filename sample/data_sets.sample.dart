final Map<String, dynamic> sampleDataSets = {
  "pager": {"page": 1, "pageCount": 1, "total": 24, "pageSize": 50},
  "dataSets": [
    {
      "code": "DS_394131",
      "created": "2012-06-10T00:36:10.036",
      "lastUpdated": "2019-09-16T13:51:37.310",
      "name": "ART monthly summary",
      "id": "lyLU2wR22tC",
      "shortName": "ART 2010",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "ART monthly summary",
      "fieldCombinationRequired": false,
      "timelyDays": 0,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0,
      "sections": [
        {
          "lastUpdated": "2023-07-22T18:26:23.883",
          "created": "2021-02-08T07:51:31.840",
          "name": "Transfer",
          "id": "tVBzSm6zYLv",
          "displayName": "Transfer",
          "sortOrder": 1,
          "showRowTotals": false,
          "greyedFields": [],
          "dataElements": [
            {"dataElement": "soACnRV9gOI"}
          ]
        },
        {
          "lastUpdated": "2023-07-22T18:26:23.883",
          "created": "2021-02-08T07:51:31.840",
          "name": "Transfer",
          "id": "ttyzSm6zYLv",
          "displayName": "Transfer",
          "sortOrder": 1,
          "showRowTotals": false,
          "greyedFields": [],
          "dataElements": [
            {"dataElement": "gyudBBtgGCv"}
          ]
        },
      ],
      "dataSetElements": [
        {
          "dataElement": {
            "code": "DE_8250",
            "name": "ART entry point: No transfer out",
            "id": "soACnRV9gOI",
            "shortName": "ART.E.P:transferOut",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No transfer out",
            "displayFormName": "ART entry point: No transfer out",
            "zeroIsSignificant": false,
            "displayShortName": "ART.E.P:transferOut",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Infant HIV test",
              "id": "oXR37f2wOb1",
              "displayName": "MNCH Infant HIV test",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "Positive",
                  "name": "Positive",
                  "id": "fWI0UiNZgMy",
                  "displayName": "Positive",
                  "sortOrder": 1,
                  "displayFormName": "Positive"
                },
                {
                  "code": "Negative",
                  "name": "Negative",
                  "id": "IRW6CQw66J7",
                  "displayName": "Negative",
                  "sortOrder": 2,
                  "displayFormName": "Negative"
                },
                {
                  "code": "Postive √",
                  "name": "Positive (Confirmed)",
                  "id": "JWyCKF6i9l1",
                  "displayName": "Positive (Confirmed)",
                  "sortOrder": 3,
                  "displayFormName": "Positive (Confirmed)"
                },
                {
                  "code": "Negative-Conf",
                  "name": "Negative (Confirmed)",
                  "id": "nzR5kXqejCc",
                  "displayName": "Negative (Confirmed)",
                  "sortOrder": 4,
                  "displayFormName": "Negative (Confirmed)"
                }
              ]
            },
            "categoryCombo": {
              "name": "IDSR (Case Age Sex)",
              "id": "sbY37PWvJBp",
              "displayName": "IDSR (Case Age Sex)",
              "categoryOptionCombos": [
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "Dth <5M",
                  "created": "2012-05-23T22:16:57.711",
                  "id": "LZsl9VW71qr",
                  "ignoreApproval": false,
                  "displayName": "Death , < 5, ME",
                  "name": "Death , < 5, ME",
                  "displayFormName": "Death , < 5, ME"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "CS >5M",
                  "created": "2012-05-23T22:16:57.710",
                  "id": "FRzeEpefSK8",
                  "ignoreApproval": false,
                  "displayName": "Case, > 5, ME",
                  "name": "Case, > 5, ME",
                  "displayFormName": "Case, > 5, ME"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "CS <5M",
                  "created": "2012-05-23T22:16:57.713",
                  "id": "AttDwO4xCIu",
                  "ignoreApproval": false,
                  "displayName": "Case, < 5, ME",
                  "name": "Case, < 5, ME",
                  "displayFormName": "Case, < 5, ME"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "Dth >5M",
                  "created": "2012-05-23T22:16:57.711",
                  "id": "lW9u3eKdMXH",
                  "ignoreApproval": false,
                  "displayName": "Death , > 5, ME",
                  "name": "Death , > 5, ME",
                  "displayFormName": "Death , > 5, ME"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "CS >5F",
                  "created": "2012-05-23T22:16:57.712",
                  "id": "q3GdT7f6iw9",
                  "ignoreApproval": false,
                  "displayName": "Case, > 5, KE",
                  "name": "Case, > 5, KE",
                  "displayFormName": "Case, > 5, KE"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "Dth <5F",
                  "created": "2012-05-23T22:16:57.714",
                  "id": "ifRTBcyGzHU",
                  "ignoreApproval": false,
                  "displayName": "Death , < 5, KE",
                  "name": "Death , < 5, KE",
                  "displayFormName": "Death , < 5, KE"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "Dth >5F",
                  "created": "2012-05-23T22:16:57.710",
                  "id": "Q8U3fXSfxY8",
                  "ignoreApproval": false,
                  "displayName": "Death , > 5, KE",
                  "name": "Death , > 5, KE",
                  "displayFormName": "Death , > 5, KE"
                },
                {
                  "lastUpdated": "2022-11-09T11:37:08.921",
                  "code": "CS <5F",
                  "created": "2012-05-23T22:16:57.713",
                  "id": "QInmZugn9JO",
                  "ignoreApproval": false,
                  "displayName": "Case, < 5, KE",
                  "name": "Case, < 5, KE",
                  "displayFormName": "Case, < 5, KE"
                }
              ]
            }
          }
        },
        {
          "dataElement": {
            "code": "DE_374603",
            "name": "Prev. month on d4T / 3TC / NVP 12mg/60mg/100mg",
            "id": "gyudBBtgGCv",
            "shortName": "Prev d4T3TCNVP_12_60_100",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T / 3TC / NVP 12mg/60mg/100mg",
            "displayFormName": "Prev. month on d4T / 3TC / NVP 12mg/60mg/100mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T3TCNVP_12_60_100",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374653",
            "name": "Shift to AZT 300mg at 28 wks",
            "id": "AyLbN9fhY4W",
            "shortName": "ST AZT 300mg at 28w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT 300mg at 28 wks",
            "displayFormName": "Shift to AZT 300mg at 28 wks",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT 300mg at 28w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374608",
            "name": "Prev. month on AZT + 3TC 300mg + 150mg on labour",
            "id": "BI5CBuRJVSV",
            "shortName": "Prev AZT_3TC_300_150 lab",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT + 3TC 300mg + 150mg on labour",
            "displayFormName":
                "Prev. month on AZT + 3TC 300mg + 150mg on labour",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT_3TC_300_150 lab",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374625",
            "name": "New on TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "id": "w1554hhXNcq",
            "shortName": "New TDF300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "New on TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "displayFormName":
                "New on TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "New TDF300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374611",
            "name":
                "Prev. month on NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "id": "CUVDjGzRmmU",
            "shortName": "Prev NVPAZT3TC10+10+10 7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "displayFormName":
                "Prev. month on NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "Prev NVPAZT3TC10+10+10 7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374659",
            "name":
                "Shift to NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "id": "un5mkYkVKqV",
            "shortName": "ST NVPAZT3TC10+10+10 7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift to NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "displayFormName":
                "Shift to NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "ST NVPAZT3TC10+10+10 7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8243",
            "name": "ART enrollment stage 4",
            "id": "zYkwbCBALhn",
            "shortName": "ART No stage 4",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART enrollment stage 4",
            "displayFormName": "ART enrollment stage 4",
            "zeroIsSignificant": false,
            "displayShortName": "ART No stage 4",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374641",
            "name": "Shift to AZT 300mg /  3TC 150mg + EFV 600mg",
            "id": "XMsORYe4ZcA",
            "shortName": "ST AZT300_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT 300mg /  3TC 150mg + EFV 600mg",
            "displayFormName": "Shift to AZT 300mg /  3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT300_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374681",
            "name": "Shift from AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "id": "AzwEuYfWAtN",
            "shortName": "SF AZT3TCNVP300+150+200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "displayFormName":
                "Shift from AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT3TCNVP300+150+200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374636",
            "name": "Shift to d4T 30mg / 3TC 150mg / NVP 200mg",
            "id": "V651s5yIbnR",
            "shortName": "ST d4T30_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T 30mg / 3TC 150mg / NVP 200mg",
            "displayFormName": "Shift to d4T 30mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T30_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374600",
            "name":
                "Prev. month on TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "n91IylSb1JQ",
            "shortName": "Prev TDF300_ddI200_IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "Prev. month on TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev TDF300_ddI200_IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374616",
            "name": "New on AZT 300mg / 3TC 150mg + NVP 200mg",
            "id": "YX1MQLgAD92",
            "shortName": "New AZT300_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT 300mg / 3TC 150mg + NVP 200mg",
            "displayFormName": "New on AZT 300mg / 3TC 150mg + NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT300_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374602",
            "name": "Prev. month on d4T / 3TC / NVP 6mg/30mg/50mg",
            "id": "YknvQAH4LnL",
            "shortName": "Prev d4T_3TC_NVP_6_30_50",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T / 3TC / NVP 6mg/30mg/50mg",
            "displayFormName": "Prev. month on d4T / 3TC / NVP 6mg/30mg/50mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T_3TC_NVP_6_30_50",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374648",
            "name": "Shift to TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "ZgIaamZjBjz",
            "shortName": "ST TDF300_ddI200_IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift to TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "Shift to TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST TDF300_ddI200_IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374629",
            "name": "New on AZT 300mg at 28 wks",
            "id": "GgsWqA0YETj",
            "shortName": "New AZT 300mg at 28w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT 300mg at 28 wks",
            "displayFormName": "New on AZT 300mg at 28 wks",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT 300mg at 28w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8242",
            "name": "ART enrollment stage 3",
            "id": "eRwOwCpMzyP",
            "shortName": "ART No stage 3",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART enrollment stage 3",
            "displayFormName": "ART enrollment stage 3",
            "zeroIsSignificant": false,
            "displayShortName": "ART No stage 3",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8241",
            "name": "ART enrollment stage 2",
            "id": "dGdeotKpRed",
            "shortName": "ART No stage 2",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART enrollment stage 2",
            "displayFormName": "ART enrollment stage 2",
            "zeroIsSignificant": false,
            "displayShortName": "ART No stage 2",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374675",
            "name": "Shift from d4T / 3TC / NVP 12mg/60mg/100mg",
            "id": "iCGDtgPA28k",
            "shortName": "SF d4T3TCNVP_12_60_100",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T / 3TC / NVP 12mg/60mg/100mg",
            "displayFormName": "Shift from d4T / 3TC / NVP 12mg/60mg/100mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T3TCNVP_12_60_100",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374639",
            "name": "Shift to d4T 40mg + 3TC 150mg + EFV 600mg",
            "id": "a5MxE5H7d3q",
            "shortName": "ST d4T40_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T 40mg + 3TC 150mg + EFV 600mg",
            "displayFormName": "Shift to d4T 40mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T40_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374604",
            "name": "Prev. month on AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "id": "yXZd6HTew4q",
            "shortName": "Prev AZT10_3TC10_NVP10",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "displayFormName":
                "Prev. month on AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT10_3TC10_NVP10",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374656",
            "name": "Shift to AZT + 3TC 300mg + 150mg on labour",
            "id": "IJ4yZ027EmK",
            "shortName": "ST AZT_3TC_300_150 lab",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT + 3TC 300mg + 150mg on labour",
            "displayFormName": "Shift to AZT + 3TC 300mg + 150mg on labour",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT_3TC_300_150 lab",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_475164",
            "name": "New on AZT + 3TC 300mg + 150mg for 7 days after 36 weeks",
            "id": "nvsNqhfSSxd",
            "shortName": "NewAZT3TC3001507d36w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "New on AZT + 3TC 300mg + 150mg for 7 days after 36 weeks",
            "displayFormName":
                "New on AZT + 3TC 300mg + 150mg for 7 days after 36 weeks",
            "zeroIsSignificant": false,
            "displayShortName": "NewAZT3TC3001507d36w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374622",
            "name": "New on ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "PxT44IblPCq",
            "shortName": "New ABC300ddI200IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "New on ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "New ABC300ddI200IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374599",
            "name": "Prev. month on ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "id": "obbSEvaKTyW",
            "shortName": "Prev ABC300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "displayFormName":
                "Prev. month on ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev ABC300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374615",
            "name": "New on d4T 40mg + 3TC 150mg + EFV 600mg",
            "id": "fDkcJaO15aQ",
            "shortName": "New d4T40_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T 40mg + 3TC 150mg + EFV 600mg",
            "displayFormName": "New on d4T 40mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T40_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_365336",
            "name": "ART defaulters",
            "id": "aIJZ2d2QgVV",
            "shortName": "ART defaulters",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART defaulters",
            "displayFormName": "ART defaulters",
            "zeroIsSignificant": false,
            "displayShortName": "ART defaulters",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374678",
            "name": "Shift from Infant NVP 10mg/ml (2mg/kg)",
            "id": "Z5uEjG9zJNK",
            "shortName": "SF Inf NVP10 (2mg/kg)",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from Infant NVP 10mg/ml (2mg/kg)",
            "displayFormName": "Shift from Infant NVP 10mg/ml (2mg/kg)",
            "zeroIsSignificant": false,
            "displayShortName": "SF Inf NVP10 (2mg/kg)",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374677",
            "name": "Shift from AZT 300mg at 28 wks",
            "id": "LJBV91hapop",
            "shortName": "SF AZT 300mg at 28w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT 300mg at 28 wks",
            "displayFormName": "Shift from AZT 300mg at 28 wks",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT 300mg at 28w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374624",
            "name": "New on TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "tnDQ80ycQus",
            "shortName": "New TDF300_ddI200_IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "New on TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "New TDF300_ddI200_IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374666",
            "name": "Shift from AZT 300mg + 3TC 150mg + ABC 300mg ",
            "id": "gSD3Znye1hY",
            "shortName": "SF AZT300_3TC150_ABC300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT 300mg + 3TC 150mg + ABC 300mg ",
            "displayFormName": "Shift from AZT 300mg + 3TC 150mg + ABC 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT300_3TC150_ABC300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_475166",
            "name": "Shift from AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "id": "supsI55QU7E",
            "shortName": "SFAZT3TC3001507d36w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift from AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "displayFormName":
                "Shift from AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "zeroIsSignificant": false,
            "displayShortName": "SFAZT3TC3001507d36w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374633",
            "name": "New on AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "id": "pVImQlMAla4",
            "shortName": "New AZT3TCNVP300+150+200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "displayFormName": "New on AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT3TCNVP300+150+200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374593",
            "name": "Prev. month on AZT 300mg /  3TC 150mg + EFV 600mg",
            "id": "rFkRvm5Ns4a",
            "shortName": "Prev AZT300_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT 300mg /  3TC 150mg + EFV 600mg",
            "displayFormName":
                "Prev. month on AZT 300mg /  3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT300_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374628",
            "name": "New on AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "id": "xrbIG3L9DdO",
            "shortName": "New AZT10_3TC10_NVP10",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "displayFormName": "New on AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT10_3TC10_NVP10",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374623",
            "name": "New on ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "id": "la1f7sqY9sb",
            "shortName": "New ABC300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "displayFormName":
                "New on ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "New ABC300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374607",
            "name": "Prev. month on ART other regimen",
            "id": "VZPWjoT6Iyb",
            "shortName": "Prev ART other regimen",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on ART other regimen",
            "displayFormName": "Prev. month on ART other regimen",
            "zeroIsSignificant": false,
            "displayShortName": "Prev ART other regimen",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374609",
            "name": "Prev. month on AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "id": "e1eDe6JsE9j",
            "shortName": "Prev AZT3TCNVP300+150+200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "displayFormName":
                "Prev. month on AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT3TCNVP300+150+200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374682",
            "name": "Shift from AZT + 3TC 300mg + 150mg for 7 days",
            "id": "Mow8dnhE6FJ",
            "shortName": "SFAZT3TC300150for7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT + 3TC 300mg + 150mg for 7 days",
            "displayFormName": "Shift from AZT + 3TC 300mg + 150mg for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "SFAZT3TC300150for7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374652",
            "name": "Shift to AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "id": "vhT3YzTev3B",
            "shortName": "ST AZT10_3TC10_NVP10",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "displayFormName":
                "Shift to AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT10_3TC10_NVP10",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374663",
            "name": "Shift from d4T 40mg + 3TC 150mg + EFV 600mg",
            "id": "BtXmKYNBc3k",
            "shortName": "SF d4T40_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T 40mg + 3TC 150mg + EFV 600mg",
            "displayFormName": "Shift from d4T 40mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T40_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374634",
            "name": "New on AZT + 3TC 300mg + 150mg for 7 days",
            "id": "GNY9KvEmRjy",
            "shortName": "New AZT+3TC_300+150for7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT + 3TC 300mg + 150mg for 7 days",
            "displayFormName": "New on AZT + 3TC 300mg + 150mg for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT+3TC_300+150for7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374605",
            "name": "Prev. month on AZT 300mg at 28 wks",
            "id": "ReljOufQV11",
            "shortName": "Prev AZT 300mg at 28w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT 300mg at 28 wks",
            "displayFormName": "Prev. month on AZT 300mg at 28 wks",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT 300mg at 28w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8249",
            "name": "ART entry point: No transfer in",
            "id": "HDZOFvdXsqE",
            "shortName": "ART.E.P:transferIn",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No transfer in",
            "displayFormName": "ART entry point: No transfer in",
            "zeroIsSignificant": false,
            "displayShortName": "ART.E.P:transferIn",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374670",
            "name": "Shift from ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "hI7NM78r3Rg",
            "shortName": "SF ABC300ddI200IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift from ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "Shift from ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF ABC300ddI200IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8244",
            "name": "ART entry point: No diagnostic testing",
            "id": "I5MLuG16arn",
            "shortName": "ARTdiag.testing",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No diagnostic testing",
            "displayFormName": "ART entry point: No diagnostic testing",
            "zeroIsSignificant": false,
            "displayShortName": "ARTdiag.testing",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374588",
            "name": "Prev. month on d4T 30mg / 3TC 150mg / NVP 200mg",
            "id": "ZecQS9lx4j9",
            "shortName": "Prev d4T30_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T 30mg / 3TC 150mg / NVP 200mg",
            "displayFormName":
                "Prev. month on d4T 30mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T30_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374669",
            "name": "Shift from d4T 30mg + 3TC 100mg + TDF 300mg ",
            "id": "a7Pue4ht1n1",
            "shortName": "SF d4T30_3TC100_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T 30mg + 3TC 100mg + TDF 300mg ",
            "displayFormName": "Shift from d4T 30mg + 3TC 100mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T30_3TC100_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374661",
            "name": "Shift from d4T 40mg / 3TC 150mg / NVP 200mg",
            "id": "dAnZOL5kxlK",
            "shortName": "SF d4T40_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T 40mg / 3TC 150mg / NVP 200mg",
            "displayFormName": "Shift from d4T 40mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T40_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374676",
            "name": "Shift from AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "id": "t6YgakIbFif",
            "shortName": "SF AZT10_3TC10_NVP10",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "displayFormName":
                "Shift from AZT 10mg/ml + 3TC 10mg/ml + NVP 10mg/ml",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT10_3TC10_NVP10",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374673",
            "name": "Shift from TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "id": "oJLoUSMs3Ud",
            "shortName": "SF TDF300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift from TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "displayFormName":
                "Shift from TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF TDF300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374658",
            "name": "Shift to AZT + 3TC 300mg + 150mg for 7 days",
            "id": "zTWitarSrae",
            "shortName": "STAZT3TC300150for7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT + 3TC 300mg + 150mg for 7 days",
            "displayFormName": "Shift to AZT + 3TC 300mg + 150mg for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "STAZT3TC300150for7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374638",
            "name": "Shift to d4T 30mg + 3TC 150mg + EFV 600mg",
            "id": "qUY0i7PnaLS",
            "shortName": "ST d4T30_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T 30mg + 3TC 150mg + EFV 600mg",
            "displayFormName": "Shift to d4T 30mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T30_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374637",
            "name": "Shift to d4T 40mg / 3TC 150mg / NVP 200mg",
            "id": "C6yhZddXLCX",
            "shortName": "ST d4T40_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T 40mg / 3TC 150mg / NVP 200mg",
            "displayFormName": "Shift to d4T 40mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T40_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374671",
            "name": "Shift from ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "id": "lznF009R6XI",
            "shortName": "SF ABC300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift from ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "displayFormName":
                "Shift from ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF ABC300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374597",
            "name": "Prev. month on d4T 30mg + 3TC 100mg + TDF 300mg ",
            "id": "KD5UjA5V16r",
            "shortName": "Prev d4T30_3TC100_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T 30mg + 3TC 100mg + TDF 300mg ",
            "displayFormName":
                "Prev. month on d4T 30mg + 3TC 100mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T30_3TC100_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374590",
            "name": "Prev. month on d4T 30mg + 3TC 150mg + EFV 600mg",
            "id": "FQhY9n5Ft7t",
            "shortName": "Prev d4T30_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T 30mg + 3TC 150mg + EFV 600mg",
            "displayFormName":
                "Prev. month on d4T 30mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T30_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374679",
            "name": "Shift from ART other regimen",
            "id": "Jw8BIUYVMGE",
            "shortName": "SF ART other regimen",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from ART other regimen",
            "displayFormName": "Shift from ART other regimen",
            "zeroIsSignificant": false,
            "displayShortName": "SF ART other regimen",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374644",
            "name": "Shift to d4T 30mg + 3TC 100mg + ABC 300mg",
            "id": "YTmhoGBxE2m",
            "shortName": "ST d4T30_3TC100_ABC 300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T 30mg + 3TC 100mg + ABC 300mg",
            "displayFormName": "Shift to d4T 30mg + 3TC 100mg + ABC 300mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T30_3TC100_ABC 300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374646",
            "name": "Shift to ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "hUSSNufoUQz",
            "shortName": "ST ABC300ddI200IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift to ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "Shift to ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST ABC300ddI200IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8240",
            "name": "ART enrollment stage 1",
            "id": "BOSZApCrBni",
            "shortName": "ART No stage 1",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART enrollment stage 1",
            "displayFormName": "ART enrollment stage 1",
            "zeroIsSignificant": false,
            "displayShortName": "ART No stage 1",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374627",
            "name": "New on d4T / 3TC / NVP 12mg/60mg/100mg",
            "id": "YIDKw3om85t",
            "shortName": "New d4T3TCNVP_12_60_100",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T / 3TC / NVP 12mg/60mg/100mg",
            "displayFormName": "New on d4T / 3TC / NVP 12mg/60mg/100mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T3TCNVP_12_60_100",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374619",
            "name": "New on AZT 300mg + 3TC 150mg + TDF 300mg ",
            "id": "wIQ5ugpWYUH",
            "shortName": "New AZT300_3TC150_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT 300mg + 3TC 150mg + TDF 300mg ",
            "displayFormName": "New on AZT 300mg + 3TC 150mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT300_3TC150_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374598",
            "name":
                "Prev. month on ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "D33rH8UHKlZ",
            "shortName": "Prev ABC300ddI200IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "Prev. month on ABC 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev ABC300ddI200IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374591",
            "name": "Prev. month on d4T 40mg + 3TC 150mg + EFV 600mg",
            "id": "XVzfK55tu7h",
            "shortName": "Prev d4T40_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T 40mg + 3TC 150mg + EFV 600mg",
            "displayFormName":
                "Prev. month on d4T 40mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T40_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374606",
            "name": "Prev. month on Infant NVP 10mg/ml (2mg/kg)",
            "id": "iri7NSiuRc3",
            "shortName": "Prev Inf NVP10 (2mg/kg)",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on Infant NVP 10mg/ml (2mg/kg)",
            "displayFormName": "Prev. month on Infant NVP 10mg/ml (2mg/kg)",
            "zeroIsSignificant": false,
            "displayShortName": "Prev Inf NVP10 (2mg/kg)",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374664",
            "name": "Shift from AZT 300mg / 3TC 150mg + NVP 200mg",
            "id": "pSHgU0Wf4ir",
            "shortName": "SF AZT300_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT 300mg / 3TC 150mg + NVP 200mg",
            "displayFormName": "Shift from AZT 300mg / 3TC 150mg + NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT300_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8252",
            "name": "ART new clients started on ARV",
            "id": "QrhlrvV6Xs8",
            "shortName": "ARTnewC.startedARV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART new clients started on ARV",
            "displayFormName": "ART new clients started on ARV",
            "zeroIsSignificant": false,
            "displayShortName": "ARTnewC.startedARV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374654",
            "name": "Shift to Infant NVP 10mg/ml (2mg/kg)",
            "id": "E7QJ0voitk7",
            "shortName": "ST Inf NVP10 (2mg/kg)",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to Infant NVP 10mg/ml (2mg/kg)",
            "displayFormName": "Shift to Infant NVP 10mg/ml (2mg/kg)",
            "zeroIsSignificant": false,
            "displayShortName": "ST Inf NVP10 (2mg/kg)",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374667",
            "name": "Shift from AZT 300mg + 3TC 150mg + TDF 300mg ",
            "id": "MeAvt39JtqN",
            "shortName": "SF AZT300_3TC150_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT 300mg + 3TC 150mg + TDF 300mg ",
            "displayFormName": "Shift from AZT 300mg + 3TC 150mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT300_3TC150_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8253",
            "name": "ART clients with new adverse clinical event",
            "id": "NJnhOzjaLYk",
            "shortName": "ART.CnewAdv.Clin.Ev.",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART clients with new adverse clinical event",
            "displayFormName": "ART clients with new adverse clinical event",
            "zeroIsSignificant": false,
            "displayShortName": "ART.CnewAdv.Clin.Ev.",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374683",
            "name":
                "Shift from NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "id": "HmBwa7GWGRG",
            "shortName": "SF NVPAZT3TC10+10+10 7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift from NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "displayFormName":
                "Shift from NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "SF NVPAZT3TC10+10+10 7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374592",
            "name": "Prev. month on AZT 300mg / 3TC 150mg + NVP 200mg",
            "id": "pgzNTiQwMES",
            "shortName": "Prev AZT300_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT 300mg / 3TC 150mg + NVP 200mg",
            "displayFormName":
                "Prev. month on AZT 300mg / 3TC 150mg + NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT300_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374680",
            "name": "Shift from AZT + 3TC 300mg + 150mg on labour",
            "id": "q9CskFaFGE6",
            "shortName": "SF AZT_3TC_300_150 lab",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT + 3TC 300mg + 150mg on labour",
            "displayFormName": "Shift from AZT + 3TC 300mg + 150mg on labour",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT_3TC_300_150 lab",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8245",
            "name": "ART entry point: No walk in",
            "id": "FTy5pcJZ3yX",
            "shortName": "ART No walk in",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No walk in",
            "displayFormName": "ART entry point: No walk in",
            "zeroIsSignificant": false,
            "displayShortName": "ART No walk in",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8258",
            "name": "ART treatment stopped due to loss to follow-up",
            "id": "TyQ1vOHM6JO",
            "shortName": "ARTstop.LossFollowup",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART treatment stopped due to loss to follow-up",
            "displayFormName": "ART treatment stopped due to loss to follow-up",
            "zeroIsSignificant": false,
            "displayShortName": "ARTstop.LossFollowup",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374613",
            "name": "New on d4T 40mg / 3TC 150mg / NVP 200mg",
            "id": "xUNvvqqhNwz",
            "shortName": "New d4T40_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T 40mg / 3TC 150mg / NVP 200mg",
            "displayFormName": "New on d4T 40mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T40_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374642",
            "name": "Shift to AZT 300mg + 3TC 150mg + ABC 300mg ",
            "id": "PNlOOplRNOp",
            "shortName": "ST AZT300_3TC150_ABC300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT 300mg + 3TC 150mg + ABC 300mg ",
            "displayFormName": "Shift to AZT 300mg + 3TC 150mg + ABC 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT300_3TC150_ABC300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374632",
            "name": "New on AZT + 3TC 300mg + 150mg on labour",
            "id": "ozmEltb5V8d",
            "shortName": "New AZT_3TC_300_150 lab",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT + 3TC 300mg + 150mg on labour",
            "displayFormName": "New on AZT + 3TC 300mg + 150mg on labour",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT_3TC_300_150 lab",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374655",
            "name": "Shift to ART other regimen",
            "id": "DlZORv7kWSl",
            "shortName": "ST ART other regimen",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to ART other regimen",
            "displayFormName": "Shift to ART other regimen",
            "zeroIsSignificant": false,
            "displayShortName": "ST ART other regimen",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8297",
            "name": "ART No clients with new adverse drug reaction",
            "id": "rNEpbBxSyu7",
            "shortName": "ARTnewAdv.DrugReact.",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART No clients with new adverse drug reaction",
            "displayFormName": "ART No clients with new adverse drug reaction",
            "zeroIsSignificant": false,
            "displayShortName": "ARTnewAdv.DrugReact.",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374665",
            "name": "Shift from AZT 300mg /  3TC 150mg + EFV 600mg",
            "id": "jHxFwWMbXT2",
            "shortName": "SF AZT300_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from AZT 300mg /  3TC 150mg + EFV 600mg",
            "displayFormName": "Shift from AZT 300mg /  3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF AZT300_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8247",
            "name": "ART entry point: No old patients",
            "id": "LVaUdM3CERi",
            "shortName": "ART.E.P:oldPatient",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No old patients",
            "displayFormName": "ART entry point: No old patients",
            "zeroIsSignificant": false,
            "displayShortName": "ART.E.P:oldPatient",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8256",
            "name": "ART treatment stopped due to death",
            "id": "ibL7BD2vn2C",
            "shortName": "ARTStop.TRTdueDeath",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART treatment stopped due to death",
            "displayFormName": "ART treatment stopped due to death",
            "zeroIsSignificant": false,
            "displayShortName": "ARTStop.TRTdueDeath",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8246",
            "name": "ART entry point: No PMTCT",
            "id": "kVOiLDV4OC6",
            "shortName": "ART.E.P:PMTCT",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No PMTCT",
            "displayFormName": "ART entry point: No PMTCT",
            "zeroIsSignificant": false,
            "displayShortName": "ART.E.P:PMTCT",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8254",
            "name":
                "ART No clients with change of regimen due to drug toxicity",
            "id": "F53rTVTmSuF",
            "shortName": "ARTChangeRegDrugToxi",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "ART No clients with change of regimen due to drug toxicity",
            "displayFormName":
                "ART No clients with change of regimen due to drug toxicity",
            "zeroIsSignificant": false,
            "displayShortName": "ARTChangeRegDrugToxi",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374647",
            "name": "Shift to ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "id": "PBXQFnb2AOk",
            "shortName": "ST ABC300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift to ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "displayFormName":
                "Shift to ABC 300mg + ddI 200mg + LPV/r 133.3/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST ABC300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8257",
            "name":
                "ART No clients who stopped TRT due to adverse clinical status/event",
            "id": "wfKKFhBn0Q0",
            "shortName": "ARTstop.TRT.Adv.Clin",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "ART No clients who stopped TRT due to adverse clinical status/event",
            "displayFormName":
                "ART No clients who stopped TRT due to adverse clinical status/event",
            "zeroIsSignificant": false,
            "displayShortName": "ARTstop.TRT.Adv.Clin",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374645",
            "name": "Shift to d4T 30mg + 3TC 100mg + TDF 300mg ",
            "id": "yB3qDR4Mlqk",
            "shortName": "ST d4T30_3TC100_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T 30mg + 3TC 100mg + TDF 300mg ",
            "displayFormName": "Shift to d4T 30mg + 3TC 100mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T30_3TC100_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374617",
            "name": "New on AZT 300mg /  3TC 150mg + EFV 600mg",
            "id": "tZLjsE0VXrL",
            "shortName": "New AZT300_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT 300mg /  3TC 150mg + EFV 600mg",
            "displayFormName": "New on AZT 300mg /  3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT300_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374668",
            "name": "Shift from d4T 30mg + 3TC 100mg + ABC 300mg",
            "id": "ZGKUt190yEn",
            "shortName": "SF d4T30_3TC100_ABC 300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T 30mg + 3TC 100mg + ABC 300mg",
            "displayFormName": "Shift from d4T 30mg + 3TC 100mg + ABC 300mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T30_3TC100_ABC 300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374657",
            "name": "Shift to AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "id": "YgsAnqU3I7B",
            "shortName": "ST AZT3TCNVP300+150+200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "displayFormName": "Shift to AZT + 3TC + NVP 300mg + 150mg + 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT3TCNVP300+150+200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_475167",
            "name": "Shift to AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "id": "jYYxzqd1dqM",
            "shortName": "STAZT3TC3001507d36w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift to AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "displayFormName":
                "Shift to AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "zeroIsSignificant": false,
            "displayShortName": "STAZT3TC3001507d36w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374674",
            "name": "Shift from d4T / 3TC / NVP 6mg/30mg/50mg",
            "id": "tlSucW8wn23",
            "shortName": "SF d4T_3TC_NVP_6_30_50",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T / 3TC / NVP 6mg/30mg/50mg",
            "displayFormName": "Shift from d4T / 3TC / NVP 6mg/30mg/50mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T_3TC_NVP_6_30_50",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374672",
            "name": "Shift from TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "id": "y6noHe7ltxY",
            "shortName": "SF TDF300_ddI200_IDV400",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift from TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "displayFormName":
                "Shift from TDF 300mg + ddI 200mg + IDV 400mg + r 100mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF TDF300_ddI200_IDV400",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8255",
            "name": "ART No clients who stopped TRT due to TRT failure",
            "id": "GMd99K8gVut",
            "shortName": "ARTStop.TRTdueFailur",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART No clients who stopped TRT due to TRT failure",
            "displayFormName":
                "ART No clients who stopped TRT due to TRT failure",
            "zeroIsSignificant": false,
            "displayShortName": "ARTStop.TRTdueFailur",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374618",
            "name": "New on AZT 300mg + 3TC 150mg + ABC 300mg ",
            "id": "xETRo03ZfOM",
            "shortName": "New AZT300_3TC150_ABC300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on AZT 300mg + 3TC 150mg + ABC 300mg ",
            "displayFormName": "New on AZT 300mg + 3TC 150mg + ABC 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "New AZT300_3TC150_ABC300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8251",
            "name": "ART No started Opportunist Infection prophylaxis",
            "id": "CxlYcbqio4v",
            "shortName": "ART.OI.prophylaxis",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART No started Opportunist Infection prophylaxis",
            "displayFormName":
                "ART No started Opportunist Infection prophylaxis",
            "zeroIsSignificant": false,
            "displayShortName": "ART.OI.prophylaxis",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374594",
            "name": "Prev. month on AZT 300mg + 3TC 150mg + ABC 300mg ",
            "id": "BVU4XA3aL0Y",
            "shortName": "Prev AZT300_3TC150_ABC300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT 300mg + 3TC 150mg + ABC 300mg ",
            "displayFormName":
                "Prev. month on AZT 300mg + 3TC 150mg + ABC 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT300_3TC150_ABC300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374589",
            "name": "Prev. month on d4T 40mg / 3TC 150mg / NVP 200mg",
            "id": "Sdfo0RBu1W3",
            "shortName": "Prev d4T40_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T 40mg / 3TC 150mg / NVP 200mg",
            "displayFormName":
                "Prev. month on d4T 40mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T40_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374614",
            "name": "New on d4T 30mg + 3TC 150mg + EFV 600mg",
            "id": "x98jMXibptT",
            "shortName": "New d4T30_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T 30mg + 3TC 150mg + EFV 600mg",
            "displayFormName": "New on d4T 30mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T30_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_475165",
            "name":
                "Prev. month on AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "id": "deGkTqbpTlS",
            "shortName": "PrevAZT3TC30015036w",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "displayFormName":
                "Prev. month on AZT + 3TC 300mg + 150mg for 7 days after 36w",
            "zeroIsSignificant": false,
            "displayShortName": "PrevAZT3TC30015036w",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374630",
            "name": "New on Infant NVP 10mg/ml (2mg/kg)",
            "id": "uN64b5MivTO",
            "shortName": "New Inf NVP10 (2mg/kg)",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on Infant NVP 10mg/ml (2mg/kg)",
            "displayFormName": "New on Infant NVP 10mg/ml (2mg/kg)",
            "zeroIsSignificant": false,
            "displayShortName": "New Inf NVP10 (2mg/kg)",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374651",
            "name": "Shift to d4T / 3TC / NVP 12mg/60mg/100mg",
            "id": "EEEu3r8z1Rg",
            "shortName": "ST d4T3TCNVP_12_60_100",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T / 3TC / NVP 12mg/60mg/100mg",
            "displayFormName": "Shift to d4T / 3TC / NVP 12mg/60mg/100mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T3TCNVP_12_60_100",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374601",
            "name":
                "Prev. month on TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "id": "cQxY2T8GenX",
            "shortName": "Prev TDF300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Prev. month on TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "displayFormName":
                "Prev. month on TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev TDF300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374626",
            "name": "New on d4T / 3TC / NVP 6mg/30mg/50mg",
            "id": "pq4msirdtpr",
            "shortName": "New d4T_3TC_NVP_6_30_50",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T / 3TC / NVP 6mg/30mg/50mg",
            "displayFormName": "New on d4T / 3TC / NVP 6mg/30mg/50mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T_3TC_NVP_6_30_50",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374612",
            "name": "New on d4T 30mg / 3TC 150mg / NVP 200mg",
            "id": "o44j6gPqFlA",
            "shortName": "New d4T30_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T 30mg / 3TC 150mg / NVP 200mg",
            "displayFormName": "New on d4T 30mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T30_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374596",
            "name": "Prev. month on d4T 30mg + 3TC 100mg + ABC 300mg",
            "id": "oYZug9IEm3Q",
            "shortName": "Prev d4T30_3TC100_ABC 300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on d4T 30mg + 3TC 100mg + ABC 300mg",
            "displayFormName":
                "Prev. month on d4T 30mg + 3TC 100mg + ABC 300mg",
            "zeroIsSignificant": false,
            "displayShortName": "Prev d4T30_3TC100_ABC 300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_8248",
            "name": "ART entry point: No other",
            "id": "vJSPn2R6gVe",
            "shortName": "ART.E.P:other",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: No other",
            "displayFormName": "ART entry point: No other",
            "zeroIsSignificant": false,
            "displayShortName": "ART.E.P:other",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374631",
            "name": "New on ART other regimen",
            "id": "lmj0xtl5P6C",
            "shortName": "New ART other regimen",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on ART other regimen",
            "displayFormName": "New on ART other regimen",
            "zeroIsSignificant": false,
            "displayShortName": "New ART other regimen",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374620",
            "name": "New on d4T 30mg + 3TC 100mg + ABC 300mg",
            "id": "hoj1wTJT6ZW",
            "shortName": "New d4T30_3TC100_ABC 300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T 30mg + 3TC 100mg + ABC 300mg",
            "displayFormName": "New on d4T 30mg + 3TC 100mg + ABC 300mg",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T30_3TC100_ABC 300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374650",
            "name": "Shift to d4T / 3TC / NVP 6mg/30mg/50mg",
            "id": "eCIPNNYj9ZM",
            "shortName": "ST d4T_3TC_NVP_6_30_50",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to d4T / 3TC / NVP 6mg/30mg/50mg",
            "displayFormName": "Shift to d4T / 3TC / NVP 6mg/30mg/50mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST d4T_3TC_NVP_6_30_50",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374640",
            "name": "Shift to AZT 300mg / 3TC 150mg + NVP 200mg",
            "id": "kxcIr99QcAO",
            "shortName": "ST AZT300_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT 300mg / 3TC 150mg + NVP 200mg",
            "displayFormName": "Shift to AZT 300mg / 3TC 150mg + NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT300_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374649",
            "name": "Shift to TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "id": "aJ9oon0aJ87",
            "shortName": "ST TDF300_ddI200_LPV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "Shift to TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "displayFormName":
                "Shift to TDF 300mg + ddI 200mg + LPV/r 133.3mg/33.3mg",
            "zeroIsSignificant": false,
            "displayShortName": "ST TDF300_ddI200_LPV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374621",
            "name": "New on d4T 30mg + 3TC 100mg + TDF 300mg ",
            "id": "SLcj0Swq8rD",
            "shortName": "New d4T30_3TC100_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "New on d4T 30mg + 3TC 100mg + TDF 300mg ",
            "displayFormName": "New on d4T 30mg + 3TC 100mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "New d4T30_3TC100_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_365337",
            "name": "Received treatment for both TB and HIV",
            "id": "gVfwyHBGWec",
            "shortName": "Treatment TB and HIV",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Received treatment for both TB and HIV",
            "displayFormName": "Received treatment for both TB and HIV",
            "zeroIsSignificant": false,
            "displayShortName": "Treatment TB and HIV",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374595",
            "name": "Prev. month on AZT 300mg + 3TC 150mg + TDF 300mg ",
            "id": "FOWABOOZtPg",
            "shortName": "Prev AZT300_3TC150_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT 300mg + 3TC 150mg + TDF 300mg ",
            "displayFormName":
                "Prev. month on AZT 300mg + 3TC 150mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "Prev AZT300_3TC150_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374635",
            "name":
                "New on NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "id": "D4PywWuIwy0",
            "shortName": "New NVPAZT3TC10+10+10 7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName":
                "New on NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "displayFormName":
                "New on NVP + AZT + 3TC 10mg/ml (2mg/kg) + 10mg/ml + 10mg/ml for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "New NVPAZT3TC10+10+10 7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374660",
            "name": "Shift from d4T 30mg / 3TC 150mg / NVP 200mg",
            "id": "mmHNj6THZNH",
            "shortName": "SF d4T30_3TC150_NVP200",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T 30mg / 3TC 150mg / NVP 200mg",
            "displayFormName": "Shift from d4T 30mg / 3TC 150mg / NVP 200mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T30_3TC150_NVP200",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374662",
            "name": "Shift from d4T 30mg + 3TC 150mg + EFV 600mg",
            "id": "ksGURIlASZB",
            "shortName": "SF d4T30_3TC150_EFV600",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift from d4T 30mg + 3TC 150mg + EFV 600mg",
            "displayFormName": "Shift from d4T 30mg + 3TC 150mg + EFV 600mg",
            "zeroIsSignificant": false,
            "displayShortName": "SF d4T30_3TC150_EFV600",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374643",
            "name": "Shift to AZT 300mg + 3TC 150mg + TDF 300mg ",
            "id": "NV0OXpHu6x4",
            "shortName": "ST AZT300_3TC150_TDF300",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Shift to AZT 300mg + 3TC 150mg + TDF 300mg ",
            "displayFormName": "Shift to AZT 300mg + 3TC 150mg + TDF 300mg ",
            "zeroIsSignificant": false,
            "displayShortName": "ST AZT300_3TC150_TDF300",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374586",
            "name": "ART entry point: TB",
            "id": "Yf4u4QOIdsi",
            "shortName": "ART entry point: TB",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "ART entry point: TB",
            "displayFormName": "ART entry point: TB",
            "zeroIsSignificant": false,
            "displayShortName": "ART entry point: TB",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        },
        {
          "dataElement": {
            "code": "DE_374610",
            "name": "Prev. month on AZT + 3TC 300mg + 150mg for 7 days",
            "id": "FDpeT1lFQMM",
            "shortName": "PrevAZT3TC300150f7d",
            "aggregationType": "SUM",
            "domainType": "AGGREGATE",
            "displayName": "Prev. month on AZT + 3TC 300mg + 150mg for 7 days",
            "displayFormName":
                "Prev. month on AZT + 3TC 300mg + 150mg for 7 days",
            "zeroIsSignificant": false,
            "displayShortName": "PrevAZT3TC300150f7d",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "optionSetValue": false
          }
        }
      ]
    },
    {
      "created": "2017-05-16T16:44:14.212",
      "lastUpdated": "2017-05-19T15:14:21.646",
      "name": "Emergency Response",
      "id": "Lpw6GcnTrmS",
      "shortName": "Emergency Response",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "Emergency Response",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_1149441",
      "created": "2012-11-14T17:58:46.725",
      "lastUpdated": "2014-11-21T11:39:48.041",
      "name": "EPI Stock",
      "id": "TuL8IOPzpHh",
      "shortName": "EPI Stock",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "EPI Stock",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "EXP",
      "created": "2018-05-16T18:47:36.063",
      "lastUpdated": "2018-05-16T19:04:13.063",
      "name": "Expenditures",
      "id": "rsyjyJmYD4J",
      "shortName": "Expenditures",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "Expenditures",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "FinancialApril",
      "openFuturePeriods": 2,
      "expiryDays": 0
    },
    {
      "code": "DS_1151444",
      "created": "2013-05-29T22:50:29.352",
      "lastUpdated": "2016-04-19T13:23:07.154",
      "name": "Facility Assessment",
      "id": "V8MHeZHIrcP",
      "shortName": "Facility Assessment",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "Facility Assessment",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Yearly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "HIV_CARE",
      "created": "2017-03-12T20:30:53.575",
      "lastUpdated": "2017-03-12T20:36:03.542",
      "name": "HIV Care Monthly",
      "id": "vc6nF5yZsPR",
      "shortName": "HIV Care Monthly",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "HIV Care Monthly",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_377538",
      "created": "2012-06-09T21:17:01.656",
      "lastUpdated": "2014-11-11T21:52:48.505",
      "name": "HIV Peadiatric monthly summary",
      "id": "EDzMBk0RRji",
      "shortName": "HIV Pead.",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "HIV Peadiatric monthly summary",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "created": "2017-05-22T11:23:37.818",
      "lastUpdated": "2017-05-22T11:23:37.818",
      "name": "IDSR Weekly",
      "id": "Nyh6laLdBEJ",
      "shortName": "IDSR Weekly",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "IDSR Weekly",
      "description": "IDSR Weekly",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Weekly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "created": "2017-05-24T13:39:13.110",
      "lastUpdated": "2017-05-24T13:51:43.710",
      "name": "IDSR Weekly (Start Wednesday)",
      "id": "j38YW1Am7he",
      "shortName": "IDSR Weekly (Start Wednesday)",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "IDSR Weekly (Start Wednesday)",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "WeeklyWednesday",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_1151033",
      "created": "2013-04-09T14:21:37.532",
      "lastUpdated": "2013-04-09T14:53:59.971",
      "name": "Inpatient Morbidity/Mortality Summary",
      "id": "PLq9sJluXvc",
      "shortName": "Inpatient Morbidity/Mortality Summary",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "Inpatient Morbidity/Mortality Summary",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_1153709",
      "created": "2014-03-02T02:21:36.553",
      "lastUpdated": "2014-03-03T17:01:18.499",
      "name": "Life-Saving Commodities",
      "id": "ULowA8V3ucd",
      "shortName": "Life-Saving Commodities",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "Life-Saving Commodities",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_1151032",
      "created": "2013-04-09T14:21:03.334",
      "lastUpdated": "2013-04-09T14:40:00.675",
      "name": "MNCH Quarterly Report",
      "id": "EKWVBc5C0ms",
      "shortName": "MNCH Quarterly Report",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "MNCH Quarterly Report",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Quarterly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_359414",
      "created": "2012-11-14T18:03:57.069",
      "lastUpdated": "2014-04-06T11:48:59.396",
      "name": "Morbidity",
      "id": "eZDhcZi6FLP",
      "shortName": "Morbidity",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "Morbidity",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_1148628",
      "created": "2011-12-24T12:24:22.881",
      "lastUpdated": "2015-08-06T13:34:47.996",
      "name": "Mortality < 5 years",
      "id": "pBOMPrpg1QX",
      "shortName": "Mortality < 5 years",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "Mortality < 5 years",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 12,
      "expiryDays": 0
    },
    {
      "code": "DS_242322",
      "created": "2016-10-10T16:17:29.155",
      "lastUpdated": "2016-10-12T13:20:45.583",
      "name": "Mortality < 5 years by age group",
      "id": "ce7DSxx5H2I",
      "shortName": "Mortality < 5 years by age group",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "Mortality < 5 years by age group",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_812532",
      "created": "2016-10-10T15:43:50.026",
      "lastUpdated": "2016-10-12T13:21:05.884",
      "name": "Mortality < 5 years by gender",
      "id": "YFTk3VdO9av",
      "shortName": "Mortality < 5 years by gender",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "Mortality < 5 years by gender",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_283467",
      "created": "2014-11-19T14:01:50.578",
      "lastUpdated": "2014-11-19T14:05:34.742",
      "name": "Mortality < 5 years Narratives",
      "id": "YZhd4nu3mzY",
      "shortName": "Mortality < 5 years Narratives",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "Mortality < 5 years Narratives",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_363642",
      "created": "2011-12-24T12:24:22.881",
      "lastUpdated": "2013-10-16T17:47:40.718",
      "name": "PMTCT monthly summary",
      "id": "Rl58JxmKJo2",
      "shortName": "PMTCT",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": true,
      "displayName": "PMTCT monthly summary",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_490350",
      "created": "2012-07-31T20:58:04.521",
      "lastUpdated": "2014-09-24T11:34:35.458",
      "name": "Population",
      "id": "aLpVgfXiz0f",
      "shortName": "Population",
      "renderHorizontally": false,
      "formType": "DEFAULT",
      "renderAsTabs": false,
      "displayName": "Population",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Yearly",
      "openFuturePeriods": 12,
      "expiryDays": 0
    },
    {
      "code": "DS_123523",
      "created": "2015-10-19T11:37:41.111",
      "lastUpdated": "2015-10-20T12:06:59.537",
      "name": "Project Management",
      "id": "Y8gAn9DfAGU",
      "shortName": "Project Management",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "Project Management",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Quarterly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_359593",
      "created": "2012-11-05T15:51:54.891",
      "lastUpdated": "2015-02-24T16:03:36.928",
      "name": "Reproductive Health",
      "id": "QX4ZTUbOt3a",
      "shortName": "Reproductive Health",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "Reproductive Health",
      "fieldCombinationRequired": false,
      "timelyDays": 10,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_360545",
      "created": "2012-11-14T18:12:41.566",
      "lastUpdated": "2014-11-18T09:46:56.631",
      "name": "Staffing",
      "id": "N4fIX1HL3TQ",
      "shortName": "Staffing",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "Staffing",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "SixMonthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_543073",
      "created": "2012-07-31T22:06:02.388",
      "lastUpdated": "2019-09-16T13:52:33.635",
      "name": "TB Facility Reporting Form",
      "id": "SF8FDSqw30D",
      "shortName": "TB Facility Reporting",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "TB Facility Reporting Form",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_387142",
      "created": "2011-12-24T12:24:22.881",
      "lastUpdated": "2013-04-09T21:41:39.734",
      "name": "TB/HIV (VCCT) monthly summary",
      "id": "OsPTWNqq26W",
      "shortName": "TB/HIV (VCCT)",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "TB/HIV (VCCT) monthly summary",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    }
  ]
};

final Map<String, dynamic> chunkedSampleDataSets = {
  "pager": {"page": 1, "pageCount": 1, "total": 2, "pageSize": 50},
  "dataSets": [
    {
      "code": "DS_359711",
      "created": "2012-11-14T18:00:36.863",
      "lastUpdated": "2018-02-07T18:25:06.530",
      "name": "Child Health",
      "id": "BfMAe6Itzgt",
      "shortName": "Child Health",
      "renderHorizontally": false,
      "formType": "SECTION",
      "renderAsTabs": false,
      "displayName": "Child Health",
      "fieldCombinationRequired": false,
      "timelyDays": 0,
      "periodType": "Monthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    },
    {
      "code": "DS_217115",
      "created": "2014-04-25T10:38:13.289",
      "lastUpdated": "2019-09-16T13:52:00.231",
      "name": "Clinical Monitoring Checklist ",
      "id": "VTdjfLXXmoi",
      "shortName": "Clinical Monitoring Checklist ",
      "renderHorizontally": false,
      "formType": "CUSTOM",
      "renderAsTabs": false,
      "displayName": "Clinical Monitoring Checklist ",
      "fieldCombinationRequired": false,
      "timelyDays": 15,
      "periodType": "SixMonthly",
      "openFuturePeriods": 0,
      "expiryDays": 0
    }
  ]
};
