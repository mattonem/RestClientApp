Class {
	#name : #PjRestClient,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'client'
	],
	#category : #RestClientApp
}

{ #category : #'as yet unclassified' }
PjRestClient class >> appHtmlUrlString [
	^ 'http://localhost:3000/'
]

{ #category : #accessing }
PjRestClient >> addDataRow [

	| dataDiv row key value |
	dataDiv := document getElementById: #dataDiv.
	row := self addElement: 'div' to: dataDiv.
	self cssClassesElement: row set: #( 'mb-3' row ).
	key := self addElement: 'input' to: row.
	self attribute: 'type' ofElement: key set: 'text'.
	self cssClassesElement: key set: #( 'col-auto' key).
	value := self addElement: 'input' to: row.
	self attribute: 'type' ofElement: value set: 'text'.
	self cssClassesElement: value set: #( 'col-auto' value).
	key
		addEventListener: #change
		block: [ client dataKey: key value value: value value ].
	value
		addEventListener: #change
		block: [ client dataKey: key value value: value value ]
]

{ #category : #accessing }
PjRestClient >> start [

	| urlInput submitButton resultPre methodSelect addDataButton |
	super start.
	client := RestClient new.
	urlInput := document getElementById: #url.
	methodSelect := document getElementById: #method.
	submitButton := document getElementById: #send.
	addDataButton := document getElementById: #addData.
	client method: 'GET'.
	addDataButton
		addEventListener: #click
		block: [ self addDataRow ].
	methodSelect
		addEventListener: #change
		block: [ client method: methodSelect value ].
	urlInput
		addEventListener: #change
		block: [ client url: urlInput value ].
	resultPre := document getElementById: #result.
	client onComplete: [ :reponse | 
		console log: reponse.
		resultPre innerHTML: reponse ].
	submitButton addEventListener: #click block: [ client send ]
]
