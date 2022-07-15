Class {
	#name : #RestClient,
	#superclass : #Object,
	#instVars : [
		'onComplete',
		'url',
		'method',
		'queryData'
	],
	#category : #RestClientApp
}

{ #category : #'as yet unclassified' }
RestClient >> _addData: aCollection with: aZnClient [
	<javascript:'return aCollection'>
	aCollection keysAndValuesDo: [ :key :value | 
		self _formAt: key put: value with: aZnClient ].
	^ nil
]

{ #category : #accessing }
RestClient >> _formAt: aString put: aString2 with: aZnClient [ 
	<javascript:''>
	aZnClient queryAt: aString put: aString2 
]

{ #category : #'as yet unclassified' }
RestClient >> _method: aMethod url: aUrl parameters: someParam with: aClient [
	
	<javascript: 'aClient.open(aMethod, aUrl + this.encodeParam(someParam))'>
	aClient
		method: aMethod;
		url: aUrl
]

{ #category : #'as yet unclassified' }
RestClient >> _method: aMethod url: aUrl with: aClient [

	<javascript: 'aClient.open(aMethod, aUrl)'>
	aClient
		method: aMethod;
		url: aUrl
]

{ #category : #'as yet unclassified' }
RestClient >> _newClient [
	<javascript: 'return new XMLHttpRequest();'>
	^ ZnClient new
]

{ #category : #'as yet unclassified' }
RestClient >> _onComplete: aBlock with: aClient [
	<javascript: 'aClient.onreadystatechange = function() {
    aBlock(this.response)
  };'>
	onComplete := aBlock
]

{ #category : #actions }
RestClient >> _sendWith: aClient [

	| body |
	body := self _addData: queryData with: aClient.
	^ self _sendWith: aClient withBody: body
]

{ #category : #actions }
RestClient >> _sendWith: aClient withBody: body [

	<javascript: 'console.log(body);aClient.send(body);'>
	
	^ onComplete value: aClient execute contents.
]

{ #category : #'as yet unclassified' }
RestClient >> dataKey: aString value: aString2 [ 
	queryData at: aString put: aString2 
]

{ #category : #'as yet unclassified' }
RestClient >> encodeParam: aDict [

	<jsAlias: #encodeParam>
	| string |
	string := '?'.
	aDict keysAndValuesDo: [ :key :value | 
		string := string , key , '=' , value , '&' ].
	^ string
]

{ #category : #accessing }
RestClient >> initialize [
	super initialize.
	queryData := Dictionary new
]

{ #category : #accessing }
RestClient >> method: anObject [

	method := anObject
]

{ #category : #accessing }
RestClient >> onComplete: anObject [

	onComplete := anObject
]

{ #category : #actions }
RestClient >> send [

	| client |
	client := self _newClient.
	self _method: method url: url parameters: queryData with: client.
	self _onComplete: onComplete with: client.
	self _sendWith: client
]

{ #category : #accessing }
RestClient >> url: anObject [

	url := anObject
]
