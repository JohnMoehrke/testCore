## Status

Feb 2023

Still broken

## testCore

This creates a profile on Condition and Diagnos from US-Core, which produces errors in the build. The errors seem to be related to Mapping, not profiling. They seem to be related to mapping to .code.text and also .code.coding; and seem to go away when only one is mapped.

https://chat.fhir.org/#narrow/stream/179175-argonaut/topic/derived.20profiles.20are.20erroring

so, still a problem somewhere.

If I profile US-Core Immunization, I can have maps for both .vaccineCode.text and .vaccineCode.coding

But, same is not true of profiling US-Core DiagnosticReport and Condition relative to .code

Yet, I can profile FHIR core with DiagnosticReport and Condition and not have a problem mapping to .code.text and .code.coding

I wonder if the tooling treats .code differently?

### Source

The source code for this Implementation Guide can be found on [GitHub](https://github.com/JohnMoehrke/testCore)

