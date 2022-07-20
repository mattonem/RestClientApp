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
		'onLoad',
		'onAbort',
		'onError',
		'onLoadEnd',
		'onLoadStart',
		'onProgress',
		'onReadyStateChange'
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

{ #category : #actions }
PjHttpClient >> initCallbacksOn: client [
	onAbort ifNotNil: [ client addEventListener: #abort block: onAbort ].
	onError ifNotNil: [ client addEventListener: #error block: onError ].
	onLoad ifNotNil: [ client addEventListener: #load block: onLoad ].
	onLoadEnd ifNotNil: [ client addEventListener: #loadend block: onLoadEnd ].
	onLoadStart ifNotNil: [ client addEventListener: #loadstart block: onLoadStart ].
	onProgress ifNotNil: [ client addEventListener: #progress block: onProgress ].
	onTimeout ifNotNil: [ client addEventListener: #timeout block: onTimeout ].
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
PjHttpClient >> onAbort: anObject [

	onAbort := anObject
]

{ #category : #accessing }
PjHttpClient >> onError: anObject [

	onError := anObject
]

{ #category : #accessing }
PjHttpClient >> onLoad: anObject [

	onLoad := anObject 
]

{ #category : #accessing }
PjHttpClient >> onLoadEnd: anObject [

	onLoadEnd := anObject
]

{ #category : #accessing }
PjHttpClient >> onLoadStart: anObject [

	onLoadStart := anObject
]

{ #category : #accessing }
PjHttpClient >> onProgress: anObject [

	onProgress := anObject
]

{ #category : #accessing }
PjHttpClient >> onReadyStateChange: anObject [

	onReadyStateChange := anObject
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

	| client block |
	client := XMLHttpRequest new.
	client
		open: method
		url: url , (self encodeParam: queryData)
		async: true.
	client setRequestHeader: 'content-type' value: contentType.
	client instVarNamed: #timeout put: timeout.
	self initCallbacksOn: client.
	client send: body
]

{ #category : #accessing }
PjHttpClient >> timeout: aString [ 
	timeout := aString asNumber
]

{ #category : #accessing }
PjHttpClient >> url: anObject [

	url := anObject
]
