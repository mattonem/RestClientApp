Class {
	#name : #RestClient,
	#superclass : #Object,
	#instVars : [
		'onComplete',
		'url',
		'method',
		'queryData',
		'formBodyData',
		'body',
		'contentType'
	],
	#category : #RestClientApp
}

{ #category : #'as yet unclassified' }
RestClient >> _body: aBody contentType: aContentType with: aClient [

	<javascript: 'aClient.setRequestHeader("Content-Type", aContentType);'>
	^ aClient
		  contents: aBody;
		  contentType: aContentType
]

{ #category : #'as yet unclassified' }
RestClient >> _bodyFormat: aString with: aZnClient [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
RestClient >> _contentType: aString with: aClient [

	<javascript: 'aClient.setRequestHeader("Content-Type", aString);'>
	^ aClient
		  contents: body;
		  contentType: aString
]

{ #category : #'as yet unclassified' }
RestClient >> _method: aMethod url: aUrl parameters: someParam with: aClient [
	
	<javascript: 'aClient.open(aMethod, aUrl + this.encodeParam(someParam))'>
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
RestClient >> _sendWith: aClient withBody: aBody [

	<javascript: 'console.log(aBody);aClient.send(aBody);'>

	^ onComplete value: aClient execute contents.
]

{ #category : #accessing }
RestClient >> body: aString [ 
	body := aString
]

{ #category : #accessing }
RestClient >> contentType: aString [ 
	contentType := aString
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

{ #category : #'as yet unclassified' }
RestClient >> formDataKey: aString value: aString2 [ 
	formBodyData at: aString put: aString2 
]

{ #category : #accessing }
RestClient >> initialize [
	super initialize.
	queryData := Dictionary new.
	formBodyData := Dictionary new
]

{ #category : #accessing }
RestClient >> method: anObject [

	method := anObject
]

{ #category : #accessing }
RestClient >> onComplete: anObject [

	onComplete := anObject
]

{ #category : #'as yet unclassified' }
RestClient >> queryDataKey: aString value: aString2 [ 
	queryData at: aString put: aString2 
]

{ #category : #actions }
RestClient >> send [

	| client |
	client := self _newClient.
	self
		_method: method
		url: url
		parameters: queryData
		with: client.
	self _onComplete: onComplete with: client.
	body ifNotNil: [ 
		self _body: body contentType: contentType with: client ].
	self _sendWith: client withBody: body
]

{ #category : #accessing }
RestClient >> url: anObject [

	url := anObject
]
