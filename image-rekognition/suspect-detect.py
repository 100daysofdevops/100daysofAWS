import boto3

def lambda_handler(event, context):
    rekognition = boto3.client('rekognition')
    
    suspect_images = ['image1','image2','image3','image4','image5']
    
    final_results=[]
    
    for suspect in suspect_images:
        
        
        response = rekognition.compare_faces(
            SourceImage={
                'S3Object': {
                    'Bucket': 'suspect-detection-bucket',
                    'Name': suspect + '.jpg'
                }
            },
            TargetImage={
                'S3Object': {
                    'Bucket': 'suspect-detection-bucket',
                    'Name': 'detected-security-camera-image.jpg'
                }
            }
        )
        
        
        if len(response['FaceMatches']) > 0:
            final_results.append({'suspect' : suspect, 'ismatch' : 'yes', 'Similarity' : response['FaceMatches'][0]['Similarity']})
        elif len(response['UnmatchedFaces']) > 0:
            final_results.append({'suspect' : suspect, 'ismatch' : 'no'})
        
        
    
    return {
        'body': final_results
    }
