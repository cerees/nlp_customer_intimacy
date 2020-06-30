---
title: Supporting Customer Intimacy with NLP
subtitle: 
author: Fern Rees (she/her/hers)
job1: Data Scientist, Transformational Analyitics
logo: cdphp_a_plan_for_life.png
biglogo: cdphp_a_plan_for_life.png
framework : io2012
highlighter : highlight.js
knit : slidify::knit2slides
widgets: [mathjax, bootstrap, quiz]
github: {user: cerees, repo: nlp_customer_intimacy}
mode: selfcontained
hitheme: tomorrow
assets: {js: 'test.js'}
---&footer

<!-- Limit image width and height -->
<style type='text/css'>
img {
    max-height: 560px;
    max-width: 1080px;
}
</style>

<!-- Center image on slide -->
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.min.js"></script>
<script type='text/javascript'>
$(function() {
    $("p:has(img)").addClass('centered');
});
</script>

## Initial Questions

>- How can we cut down on the amount of time that it takes to process these responses manually?
>- Can we easily differentiate negative experiences from positve experiences?
>- Can we reasonably quantify these things over time?
>- What other compenents of reviews might we be able to track?

---{
tpl: thankyou}

## Defining the intial problem

---&footer

## What do these reviews look like

>- Positive Reviews
  + *"Yeah.  The person that helped me was very hepful.  I wouldn't change a thing.  A great job.  Thaks, guys."*

---&footer

## What do these reviews look like

>- Mixed Reviews
  + *""*

---&footer

## What do these reviews look like

>- Negative Reviews
  + *""*

---&footer

## What do these reviews look like

>- Non-Reviews
  + *"Hello, I don't know what's going on."*

---{
tpl: thankyou}

## Automating Review Processing

---&footer

## Steps Involved

>- Sound file creation from customer feedback process.
>- Transcribing the files using AWS.
>- Conducting an unobserved sentimet analysis to rank problematic cases.
>- Training the model using feedback from the customer intimacy team.

---&footer

## Transcription using AWS Transcribe

```python
from __future__ import print_function
import time
import boto3
transcribe = boto3.client('transcribe')
job_name = "job name"
job_uri = "https://S3 endpoint/test-transcribe/answer2.wav"
transcribe.start_transcription_job(
    TranscriptionJobName=job_name,
    Media={'MediaFileUri': job_uri},
    MediaFormat='wav',
    LanguageCode='en-US'
)
```

---&footer

## Transcription using AWS Transcribe cont.

```python
while True:
    status = transcribe.get_transcription_job(TranscriptionJobName=job_name)
    if status['TranscriptionJob']['TranscriptionJobStatus'] in ['COMPLETED', 'FAILED']:
        break
    print("Not ready yet...")
    time.sleep(5)
print(status)
```

---&footer
## Transcription Output


```python
{
      "jobName":"job ID",
      "accountId":"account ID",
      "results": {
         "transcripts":[
            {
               "transcript":" that's no answer"
            }
         ]
   }}
```

---&footer
## Sentiment scoring with AWS Comprehend


```python
serviceName = "comprehend"
regionName = "us-east-1"

#establish client, send text
client_comprehend=boto3.client(service_name=serviceName, region_name=regionName)
```

---&footer
## Sentiment scoring with AWS Comprehend cont.


```python
sentifment_results = {}
for key in json_transcrips.keys():
  txt=json_transcripts.get(key)
  if len(txt) !=0:
    sentiment_results[key]=client_comprehend.detect_sentiment(
      Text=json_transcripts.get(key),
      LanguageCode= 'en'
      )
```

---&footer
## Sentiment scoring with AWS Comprehend cont.


```python
file_names=sentiment_results.keys()
overall_sentiment=list(map(lambda k: sentiment_results.get(k).get('Sentment'), 
file_names))
sentiment_trans = list(map(lambda k: json_transcripts.get(k), 
sentiment_results.keys()))
sentiment_scores=pd.DataFrame(
  list(map(lambda k: sentiment_results.get(k).get('SentimentScore'), 
  sentiment_results.keys())),
)
```

---&footer
## Sentiment scoring with AWS Comprehend cont.


```python
sentiment_scores.index=sentiment_results.keys()
sentiment_df=pd.DataFrame([overall_sentiment, sentiment_trans], columns=file_namess).T
sentiment_df=(sentiment_scores.join(sentiment_df)
.rename(columns={0:"Sentiment",1:"TranscribedTest""}))
```

---&footer
## Sentiment scoring results


```
##   jobname mixed negative neutral positive sentiment                text
## 1   Case1 0.004      0.8   0.004    0.002  NEGATIVE Very bad experience
## 2   Case2 0.009    0.002     0.9    0.004  NEURTRAL                  Eh
## 3   Case3 0.002    0.004   0.002      0.7  POSITIVE        It was great
```


---{
tpl: thankyou}

## Next Steps

---&footer
## Next Steps
>- Have customer intimacy team review
>- Train model based upon observation
>- Explore measuring different definitions and identifying review features

---{
tpl: thankyou,
social: [{title: Fern, href: "frees@cdphp.com"}]
}

## Thank You!

<style>
.title-slide {
  background-color: #28a266; /* #28a266; ; #CA9F9D*/
}

.title-slide hgroup > h1{
 font-family: 'Oswald', 'Helvetica', sanserif; 
}

.title-slide hgroup > h1, 
.title-slide hgroup > h2 {
  color: #FFFFFF ;  /* ; #EF5150*/
}

.title-slide hgroup > p {
    color: #FFD700; /* ; #EF5150*/
}

</style>

<style>
.logo {position: absolute;
  bottom: 20px;
  left: 70px;
  z-index: 10}
</style>

<style>
slide:not(.segue) h2{color: #28a266}
</style>
