Class {
	#name : #PjHttpClientApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'client'
	],
	#category : #'PjHttpClient-App'
}

{ #category : #'as yet unclassified' }
PjHttpClientApp class >> appHtmlUrlString [
	^ super appHtmlUrlString
]

{ #category : #accessing }
PjHttpClientApp >> addQueryParamRow [

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

{ #category : #'dom update' }
PjHttpClientApp >> changeElement: domElement value: newValue [
	domElement value: newValue.
	self dispatchEvent: #change to: domElement.
]

{ #category : #'dom update' }
PjHttpClientApp >> dispatchEvent: eventName to: htmlElement [
	htmlElement dispatchEvent: (self newEvent: eventName)
]

{ #category : #'start-stop' }
PjHttpClientApp >> initAddQueryParamButton [

	| addQueryParamButton |
	addQueryParamButton := document getElementById: #addQueryParam.
	addQueryParamButton
		addEventListener: #click
		block: [ self addQueryParamRow ]
]

{ #category : #'start-stop' }
PjHttpClientApp >> initBodyFormatSelect [

	| bodyFormatSelect |
	bodyFormatSelect := document getElementById: #bodyFormat.
	bodyFormatSelect addEventListener: #change block: [ 
		client contentType: bodyFormatSelect value.
		client body: nil.
		self updateBodyForm: bodyFormatSelect value ]
]

{ #category : #'start-stop' }
PjHttpClientApp >> initMethodSelect [

	| methodSelect |
	methodSelect := document getElementById: #method.
	methodSelect
		addEventListener: #change
		block: [ client method: methodSelect value ].
	self changeElement: methodSelect value: 'GET'. 
]

{ #category : #'start-stop' }
PjHttpClientApp >> initSubmitButton [

	| submitButton |
	submitButton := document getElementById: #send.
	submitButton addEventListener: #click block: [ client send ].
	self changeElement: submitButton value: 2000
]

{ #category : #'start-stop' }
PjHttpClientApp >> initTimeout [

	| timeoutInput |
	timeoutInput := document getElementById: #timeout.

	timeoutInput
		addEventListener: #change
		block: [ client timeout: timeoutInput value ]
]

{ #category : #'start-stop' }
PjHttpClientApp >> initUrlInput [

	| urlInput |
	urlInput := document getElementById: #url.
	urlInput
		addEventListener: #change
		block: [ client url: urlInput value ]
]

{ #category : #'dom update' }
PjHttpClientApp >> newEvent: eventName [
	| event |
	event := document createEvent: #HTMLEvents.
   event initEvent: eventName with: true with: true.
	^event
]

{ #category : #'start-stop' }
PjHttpClientApp >> start [

	super start.
	client := PjHttpClient new.
	client contentType: 'application/json'.
	client method: 'GET'.
	self initTimeout.
	self initAddQueryParamButton.
	self initBodyFormatSelect.
	self initMethodSelect.
	self initUrlInput.
	self initSubmitButton.
	client onLoad: [ :aClient | 
		| resultPre |
		console log: aClient.
		resultPre := document getElementById: #result.
		resultPre innerHTML: aClient currentTarget responseText ].
	client onTimeout: [ :aClient | 
		| resultPre |
		console log: aClient.
		resultPre := document getElementById: #result.
		resultPre innerHTML: 'Request timed out' ]
]

{ #category : #accessing }
PjHttpClientApp >> updateBodyForm: format [

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
