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
		'withCredentials',
		'request'
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
PjHttpClient >> get: aString [

	^ (self syncMethod: 'GET' url: aString asString)
		send: '';
		responseText
]

{ #category : #actions }
PjHttpClient >> getUrl: anUrl do: aBlock [

	<javascript: 'this.pj_jsgetUrl_do_(anUrl, aBlock)'>
	aBlock value: [ ZnClient new get: anUrl ]
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

	| request |
	request := XMLHttpRequest new.
	request onreadystatechange: [ :event | aBlock value: event target responseText
 ].
	request open: 'GET' url: anUrl asString.
	request send:''
]

{ #category : #actions }
PjHttpClient >> method: aMethod endpoint: endpoint [ 

	^ self method: aMethod url: (baseUrl, endpoint)
]

{ #category : #actions }
PjHttpClient >> method: aMethod endpoint: endpoint queryParam: paramDict [

	^ self method: aMethod url: (baseUrl, endpoint, self encodeParam: paramDict)
]

{ #category : #actions }
PjHttpClient >> method: aMethod url: anUrl [

	^ request := self initCallbacksOn: ((PjHttpRequest open: aMethod url: anUrl)
			   withCredentials: withCredentials;
			   timeout: timeout;
			   header: defaultRequestHeader;
			   username: username password: password;
			   yourself)
]

{ #category : #actions }
PjHttpClient >> method: aMethod url: anUrl queryParam: paramDict [

	^ self method: aMethod url: (anUrl , (self encodeParam: paramDict))
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
PjHttpClient >> response [
	^ request
]

{ #category : #actions }
PjHttpClient >> syncMethod: aMethod url: anUrl [

	^ request := self initCallbacksOn:
		  ((PjHttpRequest syncOpen: aMethod url: anUrl)
			   withCredentials: withCredentials;
			   header: defaultRequestHeader;
			   username: username password: password;
			   yourself)
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
