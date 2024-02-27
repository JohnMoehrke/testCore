
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
* code.coding -> "ICD-9 # ProblemTO.icd"
* asserter -> "GetPractitioner(ProblemTO.observer)"
* clinicalStatus -> "ProblemTO.status | !ProblemTO.removed ? `#active` : todo"
* verificationStatus -> "ProblemTO.verified ? `#confirmed` : `#unconfirmed`"
* note -> "ProblemTO.comments + ProblemTO.comment"
* recordedDate -> "ProblemTO.modifiedDate"
* onsetDateTime -> "ProblemTO.onsetDate"
* abatementDateTime -> "ProblemTO.abatementDateTime"
* meta.lastUpdated -> "ProblemTO.timestamp"
* evidence.detail -> "~ProblemTO.location[hospitalLocationTO]"
* evidence.detail -> "~ProblemTO.serviceConnected"
* subject -> "patient"
* category -> "`problem-list-item`"

Instance:   ex-condition-1
InstanceOf: JFM.condition
Title: "Example 1 of a condition"
Usage: #example
Description:      """
Example from a mock
"""
//* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* subject = Reference(Patient/ex-patient)
* category = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item
* identifier[+].value = "487" 
* identifier[=].system = "https://example.org/ProblemTO.id"
* identifier[=].use = #usual
* code.text = "Hypertension (ICD-9-CM 401.9)"
* code.coding = http://terminology.hl7.org/CodeSystem/icd9cm#401.9
//* asserter = Reference(Practitioner/ex-MHV-practitioner-110)
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#unconfirmed
* recordedDate = "1995-09-27"
* meta.lastUpdated = "1995-09-27T00:00:00Z"


Profile: JFMlabReport
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab
//Parent: DiagnosticReport
Id: JFM.labReport
Title: "JFM Lab Report"
Description: """
A profile showing how to derive from us-core
"""
* identifier 1..


Mapping: Lab-Mapping-LabReportTO
Source:	JFMlabReport
Target: "LabReportTO"
Title: "VDIF to MHV-PHR"
* -> "LabReportTO" "MHV PHR FHIR API"
* category -> "`laboratory`"
* status -> "`final`"
* subject -> "patient"
* code.text -> "LabReportTO.title"
* code.coding -> "LabReportTO.type -- should be converted to LOINC"

Instance: ex-labReport-1
InstanceOf: JFM.labReport 
Title: "Example 1 of an JFM labReport"
Usage: #example
Description: """
Example from a mock labReportTO
"""
//* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #final
* category[LaboratorySlice] = http://terminology.hl7.org/CodeSystem/v2-0074#LAB
* code.text = "LR MICROBIOLOGY REPORT"
* code = LOINC#79381-0
* subject = Reference(Patient/ex-patient)
* effectiveDateTime = 1995-08-03T14:49:00Z
* issued = 1995-08-03T14:49:00Z
* identifier[+].value = "MI;7049269" 
* identifier[=].system = "https://example.org/LabReportTO.id"
* identifier[=].use = #usual
* conclusion = """
NO OVA OR PARASITES FOUND
"""

Profile:        JFMimmunization
Parent:         http://hl7.org/fhir/us/core/StructureDefinition/us-core-immunization
Id:             JFM.immunization
Title:          "JFM Immunization"
Description:    """
A profile on the Immunization that builds on us-core
"""
* identifier 1..

Mapping: Immunization-Mapping
Source:	JFMimmunization
Target: "ImmunizationTO"
Title: "VDIF to MHV-PHR"
* -> "ImmunizationTO" "MHV PHR FHIR API"
* vaccineCode.text -> "ImmunizationTO.name"
* vaccineCode.coding.code -> "ImmunizationTO.cptCode.id"
* vaccineCode.coding.display -> "ImmunizationTO.cptCode.name"


Instance:   ex-immunization-1
InstanceOf: JFM.immunization
Title: "Example 1 of an immunization"
Usage: #example
Description:      """
Example from a mock ImmunizationTO
"""
//* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #completed
* vaccineCode.text = "COVID-19 (MODERNA), MRNA, LNP-S, PF, 100 MCG/0.5ML DOSE OR 50 MCG/0.25ML DOSE"
* patient = Reference(Patient/ex-patient)
* occurrenceDateTime = 2022-08-08T11:15:28Z
* recorded = 2022-08-08T11:15:28Z
* primarySource = false
* identifier[+].value = "124684" 
* identifier[=].system = "https://example.org/ImmunizationTO.id"
* identifier[=].use = #usual
* note[0].text = "test"


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

Instance: ex-pain
InstanceOf: Observation
Title: "PAIN of zero"
Description: "simple observation for pain of value zero"
Usage: #example
* status = #final
* category = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs
* code.coding = http://loinc.org#72514-3 "Pain severity - 0-10 verbal numeric rating [Score] - Reported"
* code.text = "PAIN"
* subject = Reference(Patient/ex-patient)
* effectiveDateTime = "2004-01-21T11:01:00Z"
* performer.display = "self"
* valueInteger = 0
