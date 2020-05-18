# RecoverPWBAnalyseTool
This repo is to recover PWB analyse tool due to problem with pharo iceberg.

```Smalltalk
Metacello new
   githubUser: 'mahugnon' project: 'RecoverPWBAnalyseTool' commitish: 'master' path: 'src';
   baseline: 'RecoverPWBAnalyseTool';
   onConflict: [ :e | e useIncoming ];
   onUpgrade: [ :e | e useIncoming ];       
   load   
```
travis: [![Build Status](https://travis-ci.org/mahugnon/RecoverPWBAnalyseTool.svg?branch=master)](https://travis-ci.org/mahugnon/RecoverPWBAnalyseTool)
Jenkins: [![Build Status](https://ci.inria.fr/pharo-contribution/job/PowerBuilderAnalyzeTool/badge/icon)](https://ci.inria.fr/pharo-contribution/job/PowerBuilderAnalyzeTool/)
