Class {
	#name : #PjHttpClient,
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
PjHttpClient >> body: aString [ 
	body := aString
]

{ #category : #accessing }
PjHttpClient >> contentType: aString [ 
	contentType := aString
]

{ #category : #'as yet unclassified' }
PjHttpClient >> encodeParam: aDict [
	| string |
	aDict ifEmpty: [ ^ '' ].
	string := '?'.
	aDict keysAndValuesDo: [ :key :value | 
		string := string , key , '=' , value , '&' ].
	^ string
]

{ #category : #'as yet unclassified' }
PjHttpClient >> formDataKey: aString value: aString2 [ 
	formBodyData at: aString put: aString2 
]

{ #category : #accessing }
PjHttpClient >> initialize [
	super initialize.
	queryData := Dictionary new.
	formBodyData := Dictionary new.
	method := 'GET'
]

{ #category : #accessing }
PjHttpClient >> method: anObject [

	method := anObject
]

{ #category : #accessing }
PjHttpClient >> onLoad: anObject [

	onLoad := anObject 
]

{ #category : #accessing }
PjHttpClient >> onTimeout: aFullBlockClosure [ 
	onTimeout := aFullBlockClosure
]

{ #category : #accessing }
PjHttpClient >> queryDataKey: aString value: aString2 [ 
	queryData at: aString put: aString2 
]

{ #category : #actions }
PjHttpClient >> send [

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
PjHttpClient >> timeout: aString [ 
	timeout := aString asNumber
]

{ #category : #accessing }
PjHttpClient >> url: anObject [

	url := anObject
]
