Class {
	#name : #PjHttpClient,
	#superclass : #Object,
	#instVars : [
		'baseUrl',
		'timeout',
		'onTimeout',
		'onLoad',
		'onAbort',
		'onError',
		'onLoadEnd',
		'onLoadStart',
		'onProgress',
		'onReadyStateChange',
		'defaultRequestHeader',
		'username',
		'password',
		'withCredentials'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PjHttpClient-Core'
}

{ #category : #accessing }
PjHttpClient >> contentType: aString [ 
	defaultRequestHeader at: 'Content-Type' put: aString
]

{ #category : #accessing }
PjHttpClient >> defaultRequestHeaderAt: aKey put: aValue [ 
	defaultRequestHeader at: aKey put: aValue
]

{ #category : #actions }
PjHttpClient >> encodeParam: aDict [
	| string |
	aDict ifEmpty: [ ^ '' ].
	string := '?'.
	aDict keysAndValuesDo: [ :key :value | 
		string := string , key , '=' , value , '&' ].
	^ string
]

{ #category : #actions }
PjHttpClient >> getUrl: anUrl do: aBlock [

	<javascript: 'this.pj_jsgetUrl_do_(anUrl, aBlock)'>
	| response |
	response := (ZnClient new get: anUrl; response) .
	aBlock cull: response contents cull: response code
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
	^ client
]

{ #category : #accessing }
PjHttpClient >> initialize [
	super initialize.
	defaultRequestHeader := Dictionary new.

	timeout := 2000 milliSeconds
]

{ #category : #actions }
PjHttpClient >> jsgetUrl: anUrl do: aBlock [

	| req |
	req := XMLHttpRequest new.
	req onreadystatechange: [ :event |
		(event target readyState = 4) ifTrue: [
			aBlock cull: event target responseText cull: event target status ] ].
	req open: 'GET' url: anUrl asString.
	req send: ''
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
PjHttpClient >> password: anObject [

	password := anObject
]

{ #category : #accessing }
PjHttpClient >> timeout: aDuration [ 
	timeout := aDuration 
]

{ #category : #accessing }
PjHttpClient >> username: anObject [

	username := anObject
]

{ #category : #actions }
PjHttpClient >> withCredentials: aBoolean [
	withCredentials := aBoolean
]
