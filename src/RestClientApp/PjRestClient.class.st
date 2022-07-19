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
	^ super appHtmlUrlString
]

{ #category : #accessing }
PjRestClient >> addQueryParamRow [

	| dataDiv row key value col |
	dataDiv := document getElementById: #dataDiv.
	row := self addElement: 'div' to: dataDiv.
	self cssClassesElement: row set: #( 'mb-3' row ).
	col := self addElement: 'dev' to: row.
	self cssClassesElement: col set: #( 'col' ).
	key := self addElement: 'input' to: col.
	self attribute: 'type' ofElement: key set: 'text'.
	self cssClassesElement: key set: #( 'col-auto' 'form-control' key ).
	col := self addElement: 'dev' to: row.
	self cssClassesElement: col set: #( 'col' ).

	value := self addElement: 'input' to: col.
	self attribute: 'type' ofElement: value set: 'text'.
	self cssClassesElement: value set: #( 'col-auto' 'form-control' value ).
	key
		addEventListener: #change
		block: [ client queryDataKey: key value value: value value ].
	value
		addEventListener: #change
		block: [ client queryDataKey: key value value: value value ]
]

{ #category : #accessing }
PjRestClient >> start [

	| urlInput submitButton methodSelect addQueryParamButton bodyFormatSelect timeoutInput |
	super start.
	client := RestClient new.
	client contentType: 'application/json'.
	urlInput := document getElementById: #url.
	methodSelect := document getElementById: #method.
	submitButton := document getElementById: #send.
	addQueryParamButton := document getElementById: #addQueryParam.
	bodyFormatSelect := document getElementById: #bodyFormat.
	timeoutInput := document getElementById: #timeout.
	client method: 'GET'.
	timeoutInput
		addEventListener: #change
		block: [ client timeout: timeoutInput value ].
	addQueryParamButton
		addEventListener: #click
		block: [ self addQueryParamRow ].
	bodyFormatSelect addEventListener: #change block: [ 
		client contentType: bodyFormatSelect value.
		client body: nil.
		self updateBodyForm: bodyFormatSelect value ].
	methodSelect
		addEventListener: #change
		block: [ client method: methodSelect value ].
	urlInput
		addEventListener: #change
		block: [ client url: urlInput value ].

	client onComplete: [ :aClient | 
		| resultPre |
		console log: aClient.
		resultPre := document getElementById: #result.
		resultPre innerHTML: aClient currentTarget responseText ].
	client onTimeout: [ :aClient | 
		| resultPre |
		console log: aClient.
		resultPre := document getElementById: #result.
		resultPre innerHTML: 'Request timed out'].
	submitButton addEventListener: #click block: [ client send ]
]

{ #category : #accessing }
PjRestClient >> updateBodyForm: format [

	| bodySection |
	bodySection := document getElementById: #bodyForm.
	bodySection innerHTML: ''.
	format = 'application/json' ifTrue: [ 
		| textArea |
		textArea := self addElement: 'textArea' to: bodySection.
		textArea
			addEventListener: #change
			block: [ client body: textArea value ] ]
]
