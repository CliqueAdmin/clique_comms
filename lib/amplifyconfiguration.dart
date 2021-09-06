const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-west-2:27e8e979-0ac3-41a3-bb86-6f155b5aa0f8",
                            "Region": "us-west-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-west-2_xNf0JywPs",
                        "AppClientId": "1356oqngq31qgamsc06sfpk3kf",
                        "Region": "us-west-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "loginMechanisms": [
                            "EMAIL","USERNAME"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ]
                    }
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "todoapi": {
                    "endpointType": "REST",
                    "endpoint": "https://gew1vzhak3.execute-api.us-west-2.amazonaws.com/dev",
                    "region": "us-west-2",
                   "authorizationType": "NONE"
                    
                }
            }
        }
    }
}''';
