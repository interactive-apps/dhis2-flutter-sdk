## [1.1.9] 04/12/2024

- Add nullable support in program module
- Improve perfomance 

## [1.1.8] 14/10/2024 - Happy Nyerere Day

- Add APiToken grant type to HTTP requests for personal access tokens

## [1.1.7] 20/09/2024

- Add timestamp to check token expiry time
- Add implementation to renew tokens on expiry

## [1.1.6] - 09/09/2024

- Add put method in httpClient

## [1.1.5] 04/09/2024

- Improve runtime type checking for values in user orgunit model
- Add fallback for dirty value

## [1.1.4] 04/09/2024

- Fix error on type of user organisations in user entity

## [1.1.3] - 09/08/2024

- Add delete function in httpClient
- Add d2 evaluation and parsing date objects
- Add option group module
- Add option group column to program rule action
- Fix error saving relationships
- Add functionality to re-evaluate math expressions for not operators
- Add program rule expression execution for arithmetics
- Fix error saving dataValueSets for missing filters

## [1.1.2] - 13/02/2024

- Add checks on dynamic data to check for possible null values
- Add checks for availability of response body before getting resource
- Add saved attribute to tracked entity and event data
- Add default import summaries for uknown network errors
- Improve insert performance by wrapping in try catch
- Remove hardcoded program status
- Use a different field for user selected fields to avoid conflicts
- Add functionality for user fields selection on download

## [1.1.1] - 07/08/2023

- Add support to upload relationships when uploading tracker entity instances

## [1.1.0] - 06/08/2023

- Add support to download program relationships
- Add support to donwload and upload tracker relationships
- Fix issue on clearing of shared preference on log out
- Fix data synchronization issues when local data is in dirty state

### Fixes

- Improve events program rules queueing on failing rules response
- Fix error with missing code column in user authority

## [1.0.3] - 23/03/2023

### Fixes

- Improve events program rules queueing on failing rules response
- Fix error with missing code column in user authority

### New

- Add job title and phone number properties to user entity
- Add data store module

## [1.0.2] - 17/09/2022

## [1.0.0-beta.13] - 09/09/2022

- Add attribute column on attribute option table
- Add attribute column on attribute option table
- Improve datavalue set sync
- Add option to include additional search params

## [1.0.0-beta.11] - 01/04/2022

- Support validation rule execution
- Bug fixes and improvement

## [1.0.0-alpha.20] - 06/03/2022

- Resolve issues in searching by boolean values

## [1.0.0-alpha.19] - 04/03/2022

- Bug fixes and improvements

## [1.0.0-alpha.18] - 01/03/2022

- Support to save/retain most upto date data during synchronization
- Bug fixes and improvements

## [1.0.0-alpha.17] - 24/02/2022

- Support for program rule execution for non d2 conditions
- Bug fixes and improvements

## [1.0.0-alpha.16] - 16/02/2022

- Bug fixes on saving event data value

## [1.0.0-alpha.15] - 16/02/2022

- Support to download program rules, actions and variables
- Bug fixes and improvements

## [1.0.0-alpha.14] - 13/02/2022

- Support to generate data value set information
- Bug fixes

## [1.0.0-alpha.13] - 13/02/2022

- Resolve issues in saving program stage details as part of program data

## [1.0.0-alpha.12] - 10/02/2022

- Support to generate tracked entity instances along with reserved values
- Resolve issues in saving events that have no enrollments

## [1.0.0-alpha.11] - 10/02/2022

- Support to download events and save into the phone database

## [1.0.0-alpha.10] - 08/02/2022

- Support to save dataset element and options
- Support for custom query builder for fetching program stage sections
- Support to save program stage options
- Support to save dataelements for programStage

## [1.0.0-alpha.9] - 07/02/2022

- Ensure uniquness on tracked entity attribute options

## [1.0.0-alpha.8] - 07/02/2022

- Resolve issues in creating tables with relations

## [1.0.0-alpha.8] - 07/02/2022

- Resolve issues in creating tables with relations

## [1.0.0-alpha.8] - 08/02/2022

- Resolve issues in creating tables with relations

## [1.0.0-alpha.7] - 07/02/2022

- Resolve issue on appending relating relations to parent data
- Support to upload aggregate data
- Support to download reserved values for value generated attributes

## [1.0.0-alpha.6] - 05/02/2022

- Support to view list of items along with their relations
- Support to donwload items by ids

## [1.0.0-alpha.5] - 31/01/2022

- Support to upload tracked entity instances together with their attributes details

## [1.0.0-alpha.4] - 29/01/2022

- Support to save tracked entity instances together with their attributes and enrollment details

## [1.0.0-alpha.3] - 28/01/2022

- Support to fetch user organisation unit

## [1.0.0-alpha.2] - 17/01/2022

- Support for downloading metadata

## [1.0.0-alpha.1] - 06/01/2022

- Support for online authenitication
