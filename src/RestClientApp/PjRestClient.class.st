Class {
	#name : #PjRestClient,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'client'
	],
	#category : #RestClientApp
}

{ #category : #accessing }
PjRestClient >> start [

	| urlInput submitButton resultPre |
	super start.
	client := RestClient new.
	urlInput := document getElementById: #url.
	submitButton := document getElementById: #send.
	urlInput
		addEventListener: #change
		block: [ client method: 'GET'; url: urlInput value ].
	resultPre := document getElementById:
		                            #result.
	client onComplete: [ :reponse | 
			console log: reponse.
			resultPre innerHTML: reponse ].
	submitButton addEventListener: #click block: [ 
		client send.
		 ]
]
