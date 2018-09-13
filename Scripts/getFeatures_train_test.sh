train=$1
test=$2
fullCorpus=$3
featureSet=$4  ## connected by _
featureList="$(echo $featureSet | tr '_' ' ')"
featureOutput=$5
modelLocation=$6
predictions=$7

### get features
python3 Scripts/addFeatures.py -corpus $train -fullCorpus $fullCorpus -hist $fullCorpus.hist -features $featureList > $featureOutput.train
python3 Scripts/addFeatures.py -corpus $test -fullCorpus $fullCorpus -hist $fullCorpus.hist -features $featureList > $featureOutput.test

### train crf
crfsuite learn -a pa -m $modelLocation $featureOutput.train > log.txt
rm log.txt

### test
crfsuite tag -m $modelLocation $featureOutput.test > $predictions
