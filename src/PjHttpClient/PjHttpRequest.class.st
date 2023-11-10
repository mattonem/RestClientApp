Class {
	#name : #PjHttpRequest,
	#superclass : #Object,
	#instVars : [
		'request'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PjHttpClient-Core'
}

{ #category : #'as yet unclassified' }
PjHttpRequest class >> open: aMethod url: aUrl [

	^ self new
		  open: aMethod url: aUrl;
		  yourself
]

{ #category : #'as yet unclassified' }
PjHttpRequest class >> syncOpen: aMethod url: aUrl [

	^ self new
		  syncOpen: aMethod url: aUrl;
		  yourself
]

{ #category : #'event handling' }
PjHttpRequest >> addEventListener: anEvent block: aFullBlockClosure [ 
	request addEventListener: anEvent block: aFullBlockClosure
]

{ #category : #'event handling' }
PjHttpRequest >> btoa: aString [

	<javascript: 'return btoa(aString)'>
	^ aString asByteArray base64Encoded
]

{ #category : #initialize }
PjHttpRequest >> code [

	^ request status
]

{ #category : #accessing }
PjHttpRequest >> header: aCollection [ 
	aCollection keysAndValuesDo: [ :key :value | request setRequestHeader: key put: value ]
]

{ #category : #initialization }
PjHttpRequest >> initialize [ 
	super initialize.
	request := XMLHttpRequest new.
]

{ #category : #initialize }
PjHttpRequest >> open: aMethod url: aUrl [
	console log: aUrl.
	request open: aMethod url: aUrl
]

{ #category : #accessing }
PjHttpRequest >> responseText [
	console log: request responseText.
	^ request responseText
]

{ #category : #processing }
PjHttpRequest >> send: aBody [ 
	request send: aBody
]

{ #category : #initialize }
PjHttpRequest >> status [
	^ request status
]

{ #category : #initialize }
PjHttpRequest >> syncOpen: aMethod url: aUrl [
	console log: aUrl.
	request open: aMethod url: aUrl sync: false
]

{ #category : #accessing }
PjHttpRequest >> timeout: aDuration [ 
	request instVarNamed: #timeout put: aDuration asMilliSeconds
]

{ #category : #'event handling' }
PjHttpRequest >> username: username password: password [
	username ifNil: [ ^ self ].
	password ifNil: [ ^ self ].
	request setRequestHeader: 'Authorization' value: 'Basic ', (self btoa: username, ':', password)
]

{ #category : #accessing }
PjHttpRequest >> withCredentials: aBoolean [ 
	request instVarNamed: #withCredentials put: aBoolean
]
