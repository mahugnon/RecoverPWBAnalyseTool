Extension { #name : #ThemeIcons }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
ThemeIcons >> callTreeContent [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAAbwAAAG8B8aLcQwAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AAIbSURBVDiNlZDPSxRxGMY/M3531plZW+K7tmK4SxEUwh4MotCgIMiLeOkfCAm8dOrUqXsU
BF48JV66SBB4S4Issx+EQbiZoKHrTrDur2zWmZXZ2ZkO2o/1YvvcXt7n/TwPr9LT0/O4u7v7
qqZpCm3I87ywVCrNK5lM5lve7ezyZL/XDkCrrGh9xl5NaJqmeHq/549On2wHwOzN71ozq4jf
c/LTPc4EHwAolR1WU3cgYqCYJ1B6z++bGi7B5mvU1OAfjuAIBZ+fQHYGgPDHBte75njbeIR/
GNA0kvzciQHgRztREmchYhKuzRHWCogb07C3w5ulCbzUMGJ9vhUQqa7QZxQA2CjaBGvPUSIG
6qXbhFuL+M9uQcNhUH/JUv40zcMN3N4rZPO1/TbHI3RcGAfNhHqV5sYrxOgkYb3K+pcHNHqH
UNdetAK6crOMnPoKwMesTX7uLmgmYX0HMXwfOiIosSTFiw8BUA83sC5PMdlw94drKh3RY0f9
9y8grG5Gg+xM/b8uDhRWN6PE8QTA+MhAwvPetRhc16VcLgOQSCQwDKNlr40M6AsLCzXVsqya
bdtBO+kAtm0HlmXVFMA0TXNUVVUdwPf9c+l0eiyTych/D5aXlyu5XG5KCLEKEARB3XGcWQF4
8Xh8UAiRAtjd3R2SUspCodCSKKWUxWJxLBaLLR4EbTmO81TRdf19MplMSynbemKlUtG3t7dz
vwBRqdOBxv+VTgAAAABJRU5ErkJggg=='
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
ThemeIcons >> callTreeIcon [
	^ icons
			at: #'callGraphIcon'
			ifAbsentPut:[ Form fromBinaryStream: self callTreeContents base64Decoded asByteArray readStream ]
]
