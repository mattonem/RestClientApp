Class {
	#name : #PjJSRestAppTest,
	#superclass : #PjRestAppTest,
	#traits : 'PjTAppRunsInJS',
	#classTraits : 'PjTAppRunsInJS classTrait',
	#category : #'RestClientApp-Tests'
}

{ #category : #accessing }
PjJSRestAppTest >> waitIfAsync: duration [
	duration wait
]
