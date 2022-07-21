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
		'defaultRequestHeader'
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
PjHttpClient >> method: aMethod endpoint: endpoint [ 

	^ self method: aMethod url: (baseUrl, endpoint)
]

{ #category : #actions }
PjHttpClient >> method: aMethod endpoint: endpoint queryParam: paramDict [

	^ self method: aMethod url: (baseUrl, endpoint, self encodeParam: paramDict)
]

{ #category : #actions }
PjHttpClient >> method: aMethod url: anUrl [

	^ self initCallbacksOn: ((PjHttpRequest
			    open: aMethod
			    url: anUrl)
			   timeout: timeout;
				header: defaultRequestHeader;
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
PjHttpClient >> timeout: aDuration [ 
	timeout := aDuration 
]
