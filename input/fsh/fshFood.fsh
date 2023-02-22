
Profile:        JFMcondition
Parent:         http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-problems-health-concerns
//Parent: Condition
Id:             JFM.condition
Title:          "JFM problems"
Description:    """
A profile on the Condition resource based on US-Core
"""
* identifier 1..
//* code.text 1..1


Mapping: Condition-Mapping
Source:	JFMcondition
Target: "ProblemTO"
Title: "VDIF to MHV-PHR"
* -> "ProblemTO" "MHV PHR FHIR API"
* identifier -> "ProblemTO.id"
* code.text -> "ProblemTO.type.name"
* asserter -> "GetPractitioner(ProblemTO.observer)"
* clinicalStatus -> "ProblemTO.status | !ProblemTO.removed ? `#active` : todo"
* verificationStatus -> "ProblemTO.verified ? `#confirmed` : `#unconfirmed`"
* note -> "ProblemTO.comments + ProblemTO.comment"
* recordedDate -> "ProblemTO.modifiedDate"
* onsetDateTime -> "ProblemTO.onsetDate"
* abatementDateTime -> "ProblemTO.abatementDateTime"
* meta.lastUpdated -> "ProblemTO.timestamp"
* evidence.detail -> "~ProblemTO.location[hospitalLocationTO]"
* code.coding -> "ICD-9 # ProblemTO.icd"
* evidence.detail -> "~ProblemTO.serviceConnected"
* subject -> "patient"
* category -> "`problem-list-item`"


Instance:   ex-patient
InstanceOf: Patient
Title:      "Dummy Patient example"
Description: "Dummy patient example for completeness sake. No actual use of this resource other than an example target"
Usage: #example
//* identifier = urn:uuid:2.16.840.1.113883.4.349#MVI // MVI ICN VALUE WITH CHECKSUM>
// history - http://playgroundjungle.com/2018/02/origins-of-john-jacob-jingleheimer-schmidt.html
// wiki - https://en.wikipedia.org/wiki/John_Jacob_Jingleheimer_Schmidt
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Schmidt"
* name[=].given = "John"
* name[+].use = #old
* name[=].family = "Schnidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingle"
* name[=].given[+] = "Heimer"
* name[=].period.end = "1960"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
* name[=].period.start = "1960-01-01"
* name[+].use = #nickname
* name[=].family = "Schmidt"
* name[=].given = "Jack"
* gender = #other
* birthDate = "1923-07-25"
* address.state = "WI"
* address.country = "USA"

