final Map<String, dynamic> sampleProgramStages = {
  "programStages": [
    {
      "lastUpdated": "2021-09-16T09:49:07.706",
      "id": "A03MvHH7gjR",
      "created": "2013-03-04T11:41:07.541",
      "name": "Birth",
      "program": {"id": "IpHINAT79UW"},
      "executionDateLabel": "Report date",
      "preGenerateUID": false,
      "displayName": "Birth",
      "description": "Birth of the baby",
      "displayExecutionDateLabel": "Report date",
      "openAfterEnrollment": false,
      "repeatable": false,
      "featureType": "NONE",
      "formType": "DEFAULT",
      "remindCompleted": false,
      "displayGenerateEventBox": false,
      "generatedByEnrollmentDate": false,
      "displayFormName": "Birth",
      "validationStrategy": "ON_COMPLETE",
      "autoGenerateEvent": false,
      "sortOrder": 1,
      "hideDueDate": false,
      "blockEntryForm": false,
      "enableUserAssignment": false,
      "minDaysFromStart": 0,
      "programStageDataElements": [
        {
          "lastUpdated": "2021-09-16T09:49:07.716",
          "created": "2015-03-31T09:53:05.015",
          "id": "LBNxoXdMnkv",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 0,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006098",
            "name": "MCH Apgar Score",
            "id": "a3kGcGDCuk6",
            "shortName": "Apgar Score",
            "displayDescription":
                "Apgar is a quick test performed on a baby at 1 and 5 minutes after birth. The 1-minute score determines how well the baby tolerated the birthing process. The 5-minute score tells the doctor how well the baby is doing outside the mother's womb.",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Apgar Score",
            "description":
                "Apgar is a quick test performed on a baby at 1 and 5 minutes after birth. The 1-minute score determines how well the baby tolerated the birthing process. The 5-minute score tells the doctor how well the baby is doing outside the mother's womb.",
            "displayFormName": "Apgar Score",
            "zeroIsSignificant": false,
            "displayShortName": "Apgar Score",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "formName": "Apgar Score",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.715",
          "created": "2015-08-07T14:46:19.073",
          "id": "yYMGxXpfl0Z",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 1,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_391382",
            "name": "MCH Apgar comment",
            "id": "H6uSAMO5WLD",
            "shortName": "Apgar comment",
            "aggregationType": "SUM",
            "domainType": "TRACKER",
            "displayName": "MCH Apgar comment",
            "displayFormName": "Apgar comment",
            "zeroIsSignificant": false,
            "displayShortName": "Apgar comment",
            "periodOffset": 0,
            "valueType": "LONG_TEXT",
            "formName": "Apgar comment",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.717",
          "created": "2015-03-31T09:53:05.049",
          "id": "u2FvnCDCBcD",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 2,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2005736",
            "name": "MCH Weight (g)",
            "id": "UXz7xuGCEhU",
            "shortName": "Weight (g)",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Weight (g)",
            "displayFormName": "Weight (g)",
            "zeroIsSignificant": false,
            "displayShortName": "Weight (g)",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "formName": "Weight (g)",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.716",
          "created": "2015-03-31T09:53:05.084",
          "id": "XLFc6tTftb5",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 3,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2008294",
            "name": "MCH ARV at birth",
            "id": "wQLfBvPrXqq",
            "shortName": "ARV at birth",
            "displayDescription": "Onlu used for birth details.",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH ARV at birth",
            "description": "Onlu used for birth details.",
            "displayFormName": "ARV at birth",
            "zeroIsSignificant": false,
            "displayShortName": "ARV at birth",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "ARV at birth",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Baby ARVs",
              "id": "f38bstJioPs",
              "displayName": "MNCH Baby ARVs",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "NVP only",
                  "name": "NVP only",
                  "id": "Cd0gtHGmlwS",
                  "displayName": "NVP only",
                  "sortOrder": 1,
                  "displayFormName": "NVP only"
                },
                {
                  "code": "Others",
                  "name": "Others",
                  "id": "ww8JVblo4SI",
                  "displayName": "Others",
                  "sortOrder": 2,
                  "displayFormName": "Others"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.716",
          "created": "2015-03-31T09:53:05.109",
          "id": "p8eX3rSkKN0",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 4,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006101",
            "name": "MCH BCG dose",
            "id": "bx6fsa0t90x",
            "shortName": "BCG dose",
            "aggregationType": "SUM",
            "domainType": "TRACKER",
            "displayName": "MCH BCG dose",
            "displayFormName": "BCG dose",
            "zeroIsSignificant": false,
            "displayShortName": "BCG dose",
            "periodOffset": 0,
            "valueType": "BOOLEAN",
            "formName": "BCG dose",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.716",
          "created": "2015-03-31T09:53:05.136",
          "id": "O4dwFWakvGO",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 5,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006104",
            "name": "MCH OPV dose",
            "id": "ebaJjqltK5N",
            "shortName": "OPV dose",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH OPV dose",
            "displayFormName": "OPV dose",
            "zeroIsSignificant": false,
            "displayShortName": "OPV dose",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "OPV dose",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Polio doses (0-3)",
              "id": "kzgQRhOCadd",
              "displayName": "MNCH Polio doses (0-3)",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "0",
                  "name": "Dose 0",
                  "id": "sXfZuRdvhl5",
                  "displayName": "Dose 0",
                  "sortOrder": 1,
                  "displayFormName": "Dose 0"
                },
                {
                  "code": "1",
                  "name": "Dose 1",
                  "id": "lFFqylGiWLk",
                  "displayName": "Dose 1",
                  "sortOrder": 2,
                  "displayFormName": "Dose 1"
                },
                {
                  "code": "2",
                  "name": "Dose 2",
                  "id": "Xr0M5yEhtpT",
                  "displayName": "Dose 2",
                  "sortOrder": 3,
                  "displayFormName": "Dose 2"
                },
                {
                  "code": "3",
                  "name": "Dose 3",
                  "id": "VBGXfSXgJzv",
                  "displayName": "Dose 3",
                  "sortOrder": 4,
                  "displayFormName": "Dose 3"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.715",
          "created": "2015-03-31T09:53:05.159",
          "id": "xtjAxBGQNNV",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 6,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006103",
            "name": "MCH Infant Feeding",
            "id": "X8zyunlgUfM",
            "shortName": "Infant Feeding",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Infant Feeding",
            "displayFormName": "Infant Feeding",
            "zeroIsSignificant": false,
            "displayShortName": "Infant Feeding",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Infant Feeding",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Infant Feeding",
              "id": "x31y45jvIQL",
              "displayName": "MNCH Infant Feeding",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "Exclusive",
                  "name": "Exclusive",
                  "id": "bS16xfd2E1F",
                  "displayName": "Exclusive",
                  "sortOrder": 1,
                  "displayFormName": "Exclusive"
                },
                {
                  "code": "Replacement",
                  "name": "Replacement",
                  "id": "fLCgjvxrw4c",
                  "displayName": "Replacement",
                  "sortOrder": 2,
                  "displayFormName": "Replacement"
                },
                {
                  "code": "Mixed",
                  "name": "Mixed",
                  "id": "odMfnhhpjUj",
                  "displayName": "Mixed",
                  "sortOrder": 3,
                  "displayFormName": "Mixed"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.716",
          "created": "2016-01-15T18:13:49.641",
          "id": "JYyXbTmBBls",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 7,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_424405",
            "name": "Birth certificate",
            "id": "uf3svrmp8Oj",
            "shortName": "Birth certificate",
            "aggregationType": "SUM",
            "domainType": "TRACKER",
            "displayName": "Birth certificate",
            "displayFormName": "Birth certificate",
            "zeroIsSignificant": false,
            "displayShortName": "Birth certificate",
            "periodOffset": 0,
            "valueType": "FILE_RESOURCE",
            "optionSetValue": false
          }
        }
      ]
    },
    {
      "lastUpdated": "2021-09-16T09:49:07.717",
      "id": "Z0YYXq4fJie",
      "created": "2013-03-04T11:41:07.541",
      "name": "Baby Postnatal",
      "preGenerateUID": false,
      "displayName": "Baby Postnatal",
      "description": "Baby Postnatal",
      "openAfterEnrollment": false,
      "repeatable": false,
      "featureType": "NONE",
      "formType": "DEFAULT",
      "remindCompleted": false,
      "displayGenerateEventBox": false,
      "generatedByEnrollmentDate": false,
      "displayFormName": "Baby Postnatal",
      "validationStrategy": "ON_COMPLETE",
      "autoGenerateEvent": true,
      "sortOrder": 2,
      "program": {"id": "IpHINAT79UW"},
      "hideDueDate": false,
      "blockEntryForm": false,
      "enableUserAssignment": false,
      "minDaysFromStart": 6,
      "programStageDataElements": [
        {
          "lastUpdated": "2021-09-16T09:49:07.727",
          "created": "2015-03-27T16:27:19.000",
          "id": "ztoQtbuXzsI",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 0,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006099",
            "name": "MCH Infant Weight  (g)",
            "id": "GQY2lXrypjO",
            "shortName": "Infant Weight (g)",
            "displayDescription": "Infant weight in grams",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Infant Weight  (g)",
            "description": "Infant weight in grams",
            "displayFormName": "Infant Weight (g)",
            "zeroIsSignificant": false,
            "displayShortName": "Infant Weight (g)",
            "periodOffset": 0,
            "valueType": "NUMBER",
            "formName": "Infant Weight (g)",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.725",
          "created": "2015-03-27T16:27:19.000",
          "id": "vdc1saaN2ma",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 1,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006103",
            "name": "MCH Infant Feeding",
            "id": "X8zyunlgUfM",
            "shortName": "Infant Feeding",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Infant Feeding",
            "displayFormName": "Infant Feeding",
            "zeroIsSignificant": false,
            "displayShortName": "Infant Feeding",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Infant Feeding",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Infant Feeding",
              "id": "x31y45jvIQL",
              "displayName": "MNCH Infant Feeding",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "Exclusive",
                  "name": "Exclusive",
                  "id": "bS16xfd2E1F",
                  "displayName": "Exclusive",
                  "sortOrder": 1,
                  "displayFormName": "Exclusive"
                },
                {
                  "code": "Replacement",
                  "name": "Replacement",
                  "id": "fLCgjvxrw4c",
                  "displayName": "Replacement",
                  "sortOrder": 2,
                  "displayFormName": "Replacement"
                },
                {
                  "code": "Mixed",
                  "name": "Mixed",
                  "id": "odMfnhhpjUj",
                  "displayName": "Mixed",
                  "sortOrder": 3,
                  "displayFormName": "Mixed"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.727",
          "created": "2015-08-06T13:42:22.491",
          "id": "Vpx18GqyLcK",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 2,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006125",
            "name": "MCH Measles dose",
            "id": "FqlgKAG8HOu",
            "shortName": "Measles dose",
            "aggregationType": "SUM",
            "domainType": "TRACKER",
            "displayName": "MCH Measles dose",
            "displayFormName": "Measles dose",
            "zeroIsSignificant": false,
            "displayShortName": "Measles dose",
            "periodOffset": 0,
            "valueType": "BOOLEAN",
            "formName": "Measles dose",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.729",
          "created": "2015-08-06T13:42:22.499",
          "id": "WlYechRHVo3",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 3,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_347311",
            "name": "MCH Penta dose",
            "id": "vTUhAUZFoys",
            "shortName": "Penta dose",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Penta dose",
            "displayFormName": "Penta dose",
            "zeroIsSignificant": false,
            "displayShortName": "Penta dose",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Penta dose",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Polio doses (0-3)",
              "id": "kzgQRhOCadd",
              "displayName": "MNCH Polio doses (0-3)",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "0",
                  "name": "Dose 0",
                  "id": "sXfZuRdvhl5",
                  "displayName": "Dose 0",
                  "sortOrder": 1,
                  "displayFormName": "Dose 0"
                },
                {
                  "code": "1",
                  "name": "Dose 1",
                  "id": "lFFqylGiWLk",
                  "displayName": "Dose 1",
                  "sortOrder": 2,
                  "displayFormName": "Dose 1"
                },
                {
                  "code": "2",
                  "name": "Dose 2",
                  "id": "Xr0M5yEhtpT",
                  "displayName": "Dose 2",
                  "sortOrder": 3,
                  "displayFormName": "Dose 2"
                },
                {
                  "code": "3",
                  "name": "Dose 3",
                  "id": "VBGXfSXgJzv",
                  "displayName": "Dose 3",
                  "sortOrder": 4,
                  "displayFormName": "Dose 3"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.726",
          "created": "2015-08-06T13:42:22.504",
          "id": "WucAVPYvcEO",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 4,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006126",
            "name": "MCH Yellow fever dose",
            "id": "rxBfISxXS2U",
            "shortName": "Yellow fever dose",
            "aggregationType": "SUM",
            "domainType": "TRACKER",
            "displayName": "MCH Yellow fever dose",
            "displayFormName": "Yellow fever dose",
            "zeroIsSignificant": false,
            "displayShortName": "Yellow fever dose",
            "periodOffset": 0,
            "valueType": "BOOLEAN",
            "formName": "Yellow fever dose",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.723",
          "created": "2015-08-06T14:04:45.215",
          "id": "EL5dr5x0WbZ",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 5,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2005744",
            "name": "MCH IPT dose",
            "id": "lNNb3truQoi",
            "shortName": "IPT dose",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH IPT dose",
            "displayFormName": "IPT dose",
            "zeroIsSignificant": false,
            "displayShortName": "IPT dose",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "IPT dose",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH IPT",
              "id": "nH8Y04zS7UV",
              "displayName": "MNCH IPT",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "IPT 1",
                  "name": "IPT 1",
                  "id": "BszlRcyvU2p",
                  "displayName": "IPT 1",
                  "sortOrder": 1,
                  "displayFormName": "IPT 1"
                },
                {
                  "code": "IPT 2",
                  "name": "IPT 2",
                  "id": "pXDp3sN3xJ7",
                  "displayName": "IPT 2",
                  "sortOrder": 2,
                  "displayFormName": "IPT 2"
                },
                {
                  "code": "IPT 3",
                  "name": "IPT 3",
                  "id": "KGtyXqAprCc",
                  "displayName": "IPT 3",
                  "sortOrder": 3,
                  "displayFormName": "IPT 3"
                },
                {
                  "code": "On CTX",
                  "name": "On CTX",
                  "id": "lqMX3VoXyDs",
                  "displayName": "On CTX",
                  "sortOrder": 4,
                  "displayFormName": "On CTX"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.728",
          "created": "2015-03-27T16:27:19.000",
          "id": "IpPWDRlHJSe",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 6,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006105",
            "name": "MCH DPT dose",
            "id": "pOe0ogW4OWd",
            "shortName": "DPT dose",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH DPT dose",
            "displayFormName": "DPT dose",
            "zeroIsSignificant": false,
            "displayShortName": "DPT dose",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "DPT dose",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH DPT doses (1-3)",
              "id": "udkr3ihaeD3",
              "displayName": "MNCH DPT doses (1-3)",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "1",
                  "name": "Dose 1",
                  "id": "HEjqfmniZAr",
                  "displayName": "Dose 1",
                  "sortOrder": 1,
                  "displayFormName": "Dose 1"
                },
                {
                  "code": "2",
                  "name": "Dose 2",
                  "id": "RqLFM2C8RnE",
                  "displayName": "Dose 2",
                  "sortOrder": 2,
                  "displayFormName": "Dose 2"
                },
                {
                  "code": "3",
                  "name": "Dose 3",
                  "id": "lbb3GURUxGo",
                  "displayName": "Dose 3",
                  "sortOrder": 3,
                  "displayFormName": "Dose 3"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.727",
          "created": "2015-03-27T16:27:19.000",
          "id": "xSTVGEIbarb",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 7,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006106",
            "name": "MCH Vit A",
            "id": "HLmTEmupdX0",
            "shortName": "Vit A",
            "aggregationType": "SUM",
            "domainType": "TRACKER",
            "displayName": "MCH Vit A",
            "displayFormName": "Vit A",
            "zeroIsSignificant": false,
            "displayShortName": "Vit A",
            "periodOffset": 0,
            "valueType": "BOOLEAN",
            "formName": "Vit A",
            "optionSetValue": false
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.723",
          "created": "2015-03-27T16:27:19.000",
          "id": "YCO2FVT0wXL",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 8,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006107",
            "name": "MCH Infant HIV Test Result",
            "id": "cYGaxwK615G",
            "shortName": "Infant HIV Test Result",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Infant HIV Test Result",
            "displayFormName": "Infant HIV Test Result",
            "zeroIsSignificant": false,
            "displayShortName": "Infant HIV Test Result",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Infant HIV Test Result",
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
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.728",
          "created": "2015-03-27T16:27:19.000",
          "id": "VlOvjLKnoyw",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 9,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006108",
            "name": "MCH HIV Test Type",
            "id": "hDZbpskhqDd",
            "shortName": "HIV Test Type",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH HIV Test Type",
            "displayFormName": "HIV Test Type",
            "zeroIsSignificant": false,
            "displayShortName": "HIV Test Type",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "HIV Test Type",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Infant HIV Test Type",
              "id": "OGmE3wUMEzu",
              "displayName": "MNCH Infant HIV Test Type",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "Rapid",
                  "name": "Rapid",
                  "id": "HEqorVvFV8k",
                  "displayName": "Rapid",
                  "sortOrder": 1,
                  "displayFormName": "Rapid"
                },
                {
                  "code": "PCR",
                  "name": "PCR",
                  "id": "vOSo0R6LuI1",
                  "displayName": "PCR",
                  "sortOrder": 2,
                  "displayFormName": "PCR"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.727",
          "created": "2015-03-27T16:27:19.000",
          "id": "rqmcdr07fxQ",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 10,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006100",
            "name": "MCH Child ARVs",
            "id": "sj3j9Hwc7so",
            "shortName": "Child ARVs",
            "displayDescription": "ARVs for child postnatal visits.",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Child ARVs",
            "description": "ARVs for child postnatal visits.",
            "displayFormName": "Child ARVs",
            "zeroIsSignificant": false,
            "displayShortName": "Child ARVs",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Child ARVs",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH ARVs",
              "id": "dgsftM0rXu2",
              "displayName": "MNCH ARVs",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "NVP Only",
                  "name": "NVP Only",
                  "id": "NXyMwAwxNap",
                  "displayName": "NVP Only",
                  "sortOrder": 1,
                  "displayFormName": "NVP Only"
                },
                {
                  "code": "TDF/3TC/NVP - 1",
                  "name": "TDF/3TC/NVP - 1",
                  "id": "OZH6GLUufaX",
                  "displayName": "TDF/3TC/NVP - 1",
                  "sortOrder": 2,
                  "displayFormName": "TDF/3TC/NVP - 1"
                },
                {
                  "code": "TDF/3TC/EFV - 1",
                  "name": "TDF/3TC/EFV - 1",
                  "id": "fpfMGr05G23",
                  "displayName": "TDF/3TC/EFV - 1",
                  "sortOrder": 3,
                  "displayFormName": "TDF/3TC/EFV - 1"
                },
                {
                  "code": "AZT/3TC/NVP - 1",
                  "name": "AZT/3TC/NVP - 1",
                  "id": "snKkbSbKQFi",
                  "displayName": "AZT/3TC/NVP - 1",
                  "sortOrder": 4,
                  "displayFormName": "AZT/3TC/NVP - 1"
                },
                {
                  "code": "AZT/3TC/EFV - 1",
                  "name": "AZT/3TC/EFV - 1",
                  "id": "QAr1LjJB7hV",
                  "displayName": "AZT/3TC/EFV - 1",
                  "sortOrder": 5,
                  "displayFormName": "AZT/3TC/EFV - 1"
                },
                {
                  "code": "TDF/3TC/ATV/r - 2",
                  "name": "TDF/3TC/ATV/r - 2",
                  "id": "J8tdCrlmoyp",
                  "displayName": "TDF/3TC/ATV/r - 2",
                  "sortOrder": 6,
                  "displayFormName": "TDF/3TC/ATV/r - 2"
                },
                {
                  "code": "TDF/3TC/LPV/r - 2",
                  "name": "TDF/3TC/LPV/r - 2",
                  "id": "e3Y43oVooNx",
                  "displayName": "TDF/3TC/LPV/r - 2",
                  "sortOrder": 7,
                  "displayFormName": "TDF/3TC/LPV/r - 2"
                },
                {
                  "code": "AZT/3TC/ATV/r - 2",
                  "name": "AZT/3TC/ATV/r - 2",
                  "id": "ehhkhM0cmbA",
                  "displayName": "AZT/3TC/ATV/r - 2",
                  "sortOrder": 8,
                  "displayFormName": "AZT/3TC/ATV/r - 2"
                },
                {
                  "code": "AZT/3TC/LPV/r - 2",
                  "name": "AZT/3TC/LPV/r - 2",
                  "id": "bswStRDzLny",
                  "displayName": "AZT/3TC/LPV/r - 2",
                  "sortOrder": 9,
                  "displayFormName": "AZT/3TC/LPV/r - 2"
                },
                {
                  "code": "AZT/ddl/LPV/r - 2",
                  "name": "AZT/ddl/LPV/r - 2",
                  "id": "wGQbXCz6qgd",
                  "displayName": "AZT/ddl/LPV/r - 2",
                  "sortOrder": 10,
                  "displayFormName": "AZT/ddl/LPV/r - 2"
                },
                {
                  "code": "ABC/ddl/LPV/r -2",
                  "name": "ABC/ddl/LPV/r -2",
                  "id": "bopJ9PaLnAZ",
                  "displayName": "ABC/ddl/LPV/r -2",
                  "sortOrder": 11,
                  "displayFormName": "ABC/ddl/LPV/r -2"
                },
                {
                  "code": "Other 1st line",
                  "name": "Other 1st line",
                  "id": "ARN7cNTxlRA",
                  "displayName": "Other 1st line",
                  "sortOrder": 12,
                  "displayFormName": "Other 1st line"
                },
                {
                  "code": "Other 2nd line",
                  "name": "Other 2nd line",
                  "id": "OP2n2kZ3eWw",
                  "displayName": "Other 2nd line",
                  "sortOrder": 13,
                  "displayFormName": "Other 2nd line"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.729",
          "created": "2015-03-27T16:27:19.000",
          "id": "LfgZNmadu4W",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 11,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006109",
            "name": "MCH Septrin Given",
            "id": "aei1xRjSU2l",
            "shortName": "Septrin Given",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Septrin Given",
            "displayFormName": "Septrin Given",
            "zeroIsSignificant": false,
            "displayShortName": "Septrin Given",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Septrin Given",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Yes No",
              "id": "XdI8KRJiRoZ",
              "displayName": "MNCH Yes No",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "Yes",
                  "name": "Yes",
                  "id": "AAgDQGRuOHB",
                  "displayName": "Yes",
                  "sortOrder": 1,
                  "displayFormName": "Yes"
                },
                {
                  "code": "No",
                  "name": "No",
                  "id": "kzKxayEMqZB",
                  "displayName": "No",
                  "sortOrder": 2,
                  "displayFormName": "No"
                },
                {
                  "code": "Unknown",
                  "name": "Unknown",
                  "id": "T6ZEg0zYzbL",
                  "displayName": "Unknown",
                  "sortOrder": 3,
                  "displayFormName": "Unknown"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.727",
          "created": "2015-03-27T16:27:19.000",
          "id": "sfYk4rKw18B",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 12,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2006110",
            "name": "MCH Results given to caretaker",
            "id": "BeynU4L6VCQ",
            "shortName": "Results given to caretake",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Results given to caretaker",
            "displayFormName": "Results given to caretaker",
            "zeroIsSignificant": false,
            "displayShortName": "Results given to caretake",
            "periodOffset": 0,
            "valueType": "TEXT",
            "formName": "Results given to caretaker",
            "optionSetValue": true,
            "optionSet": {
              "name": "MNCH Yes No",
              "id": "XdI8KRJiRoZ",
              "displayName": "MNCH Yes No",
              "valueType": "TEXT",
              "options": [
                {
                  "code": "Yes",
                  "name": "Yes",
                  "id": "AAgDQGRuOHB",
                  "displayName": "Yes",
                  "sortOrder": 1,
                  "displayFormName": "Yes"
                },
                {
                  "code": "No",
                  "name": "No",
                  "id": "kzKxayEMqZB",
                  "displayName": "No",
                  "sortOrder": 2,
                  "displayFormName": "No"
                },
                {
                  "code": "Unknown",
                  "name": "Unknown",
                  "id": "T6ZEg0zYzbL",
                  "displayName": "Unknown",
                  "sortOrder": 3,
                  "displayFormName": "Unknown"
                }
              ]
            }
          }
        },
        {
          "lastUpdated": "2021-09-16T09:49:07.727",
          "created": "2015-03-27T16:27:19.000",
          "id": "LiV2YoatDud",
          "displayInReports": false,
          "renderOptionsAsRadio": false,
          "compulsory": false,
          "sortOrder": 13,
          "skipSynchronization": false,
          "allowFutureDate": false,
          "dataElement": {
            "code": "DE_2008126",
            "name": "MCH Visit Comment",
            "id": "OuJ6sgPyAbC",
            "shortName": "Visit Comment",
            "displayDescription":
                "Free text comment used to put additional information for a visit.",
            "aggregationType": "AVERAGE",
            "domainType": "TRACKER",
            "displayName": "MCH Visit Comment",
            "description":
                "Free text comment used to put additional information for a visit.",
            "displayFormName": "Visit comment (optional)",
            "zeroIsSignificant": false,
            "displayShortName": "Visit Comment",
            "periodOffset": 0,
            "valueType": "LONG_TEXT",
            "formName": "Visit comment (optional)",
            "optionSetValue": false
          }
        }
      ]
    }
  ]
};
