#!/bin/bash
# DockerHub username
DOCKERHUB_USERNAME="ijeawele"
VERSION="v1.0"

# List of your services
SERVICES=(
    "emailservice"
    "shippingservice" 
    "recommendationservice"
    "cartservice"
    "productcatalogservice"
    "currencyservice"
    "paymentservice"
    "checkoutservice"
    "adservice"
    "frontend"
    "shoppingassistantservice"
)

echo "Logging into DockerHub..."
docker login

echo "pushing images with version $VERSION only..."

# Tag and push all images (version only)
for service in "${SERVICES[@]}"; do
    echo "Processing $service..."
    
    # Tag with version only
    #docker build -t $DOCKERHUB_USERNAME/$service:$VERSION
    
    # Push version tag only
    docker push $DOCKERHUB_USERNAME/$service:$VERSION
    
    echo "✅ $service:$VERSION pushed successfully"
done

echo "🎉 All images pushed successfully to DockerHub with version $VERSION!"