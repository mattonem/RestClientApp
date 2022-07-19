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
		'contentType',
		'timeout',
		'onTimeout'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #RestClientApp
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

{ #category : #accessing }
RestClient >> onTimeout: aFullBlockClosure [ 
	onTimeout := aFullBlockClosure
]

{ #category : #'as yet unclassified' }
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
		block: onComplete.
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
