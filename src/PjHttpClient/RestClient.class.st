Class {
	#name : #RestClient,
	#superclass : #Object,
	#instVars : [
		'url',
		'method',
		'queryData',
		'formBodyData',
		'body',
		'contentType',
		'timeout',
		'onTimeout',
		'onLoad'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PjHttpClient-Core'
}

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
	| string |
	aDict ifEmpty: [ ^ '' ].
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
	formBodyData := Dictionary new.
	method := 'GET'
]

{ #category : #accessing }
RestClient >> method: anObject [

	method := anObject
]

{ #category : #accessing }
RestClient >> onLoad: anObject [

	onLoad := anObject 
]

{ #category : #accessing }
RestClient >> onTimeout: aFullBlockClosure [ 
	onTimeout := aFullBlockClosure
]

{ #category : #accessing }
RestClient >> queryDataKey: aString value: aString2 [ 
	queryData at: aString put: aString2 
]

{ #category : #actions }
RestClient >> send [

	| client |
	client := XMLHttpRequest new.
	client
		open: method
		url: url , (self encodeParam: queryData)
		async: true.
	client setRequestHeader: 'content-type' value: contentType.
	client instVarNamed:#timeout put: timeout.
	client 
		addEventListener: #load
		block: onLoad.
	client 
		addEventListener: #timeout
		block: onTimeout.
	client send: body.
	
]

{ #category : #accessing }
RestClient >> timeout: aString [ 
	timeout := aString asNumber
]

{ #category : #accessing }
RestClient >> url: anObject [

	url := anObject
]
