#!/usr/bin/env cwl-runner
#
# Validate a Project (writeup) submission
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: challengeutils

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/challengeutils:develop

requirements:
  - class: InlineJavascriptRequirement

inputs:
  - id: submissionid
    type: int
  - id: challengewiki
    type: string
  - id: public
    type: boolean?
  - id: admin
    type: string?
  - id: synapse_config
    type: File

arguments:
  - valueFrom: $(inputs.synapse_config.path)
    prefix: -c
  - valueFrom: validateproject
  - valueFrom: $(inputs.submissionid)
  - valueFrom: $(inputs.challengewiki)
  - valueFrom: $(inputs.public)
    prefix: --public
  - valueFrom: $(inputs.admin)
    prefix: --admin
  - valueFrom: results.json
    prefix: --output

outputs:
  - id: results
    type: File
    outputBinding:
      glob: results.json

  - id: status
    type: string
    outputBinding:
      glob: results.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['writeup_status'])

  - id: invalid_reasons
    type: string
    outputBinding:
      glob: results.json
      loadContents: true
      outputEval: $(JSON.parse(self[0].contents)['errors_found'])