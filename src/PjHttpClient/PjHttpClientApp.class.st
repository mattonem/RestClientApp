Class {
	#name : #PjHttpClientApp,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'client',
		'methodSelect',
		'urlInput',
		'bodyFormatSelect',
		'bodyTextArea',
		'queryParam'
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
		block: [ queryParam at: key value put: value value ].
	value
		addEventListener: #change
		block: [ queryParam at: key value put: value value ]
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

	bodyFormatSelect := document getElementById: #bodyFormat.
	bodyFormatSelect addEventListener: #change block: [ 
		client contentType: bodyFormatSelect value.
		self updateBodyForm: bodyFormatSelect value ]
]

{ #category : #'start-stop' }
PjHttpClientApp >> initMethodSelect [

	methodSelect := document getElementById: #method.
	self changeElement: methodSelect value: 'GET'. 
]

{ #category : #'start-stop' }
PjHttpClientApp >> initSubmitButton [

	| submitButton |
	submitButton := document getElementById: #send.
	submitButton addEventListener: #click block: [ 
		| req body |
		req := client method: methodSelect value url: urlInput value queryParam: queryParam.
		body := bodyTextArea ifNil: [ '' ] ifNotNil: [ :area | area value ].
		req send: body ]
]

{ #category : #'start-stop' }
PjHttpClientApp >> initTimeout [

	| timeoutInput |
	timeoutInput := document getElementById: #timeout.

	timeoutInput
		addEventListener: #change
		block: [ client timeout: timeoutInput value asInteger milliSeconds ]
]

{ #category : #'start-stop' }
PjHttpClientApp >> initUrlInput [

	urlInput := document getElementById: #url
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
	queryParam := Dictionary new.
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
		resultPre innerHTML: 'Request timed out' ].
	client onProgress: [ :aClient | 
		| resultPre |
		console log: aClient ]
]

{ #category : #accessing }
PjHttpClientApp >> updateBodyForm: format [

	| bodySection |
	bodySection := document getElementById: #bodyForm.
	bodySection innerHTML: ''.
	bodyTextArea := nil.
	format = 'application/json' ifTrue: [ 
		bodyTextArea := self addElement: 'textArea' to: bodySection ]
]
