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

