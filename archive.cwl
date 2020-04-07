#!/usr/bin/env cwl-runner
#
# Archive a Project (writeup) submission
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
  - id: admin
    type: string

arguments:
  - valueFrom: $(inputs.synapse_config.path)
    prefix: -c
  - valueFrom: archiveproject
  - valueFrom: $(inputs.submissionid)
  - valueFrom: $(inputs.admin)
    prefix: --admin

outputs: [finished]