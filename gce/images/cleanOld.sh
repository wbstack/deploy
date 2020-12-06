#!/usr/bin/env bash

RED='\033[0;31m'
YELL='\033[1;33m'
NC='\033[0m' # No Color

# Keep 4 which is latest + 3 others tagged?
IMAGES_TO_KEEP="4"
IMAGE_REPO="gcr.io/wbstack"

# Get all images at the given image repo
echo -e "${YELL}Getting all images${NC}"
IMAGELIST=$(gcloud container images list --repository=${IMAGE_REPO} --format='get(name)')
echo "$IMAGELIST"

while IFS= read -r IMAGENAME; do
  IMAGENAME=$(echo $IMAGENAME|tr -d '\r')
  echo -e "${YELL}Checking ${IMAGENAME} for cleanup requirements${NC}"

  # Get all the digests for the tag ordered by timestamp (oldest first)
  DIGESTLIST=$(gcloud container images list-tags ${IMAGENAME} --sort-by timestamp --format='get(digest)')
  DIGESTLISTCOUNT=$(echo "${DIGESTLIST}" | wc -l)

  if [ ${IMAGES_TO_KEEP} -ge "${DIGESTLISTCOUNT}" ]; then
    echo -e "${YELL}Found ${DIGESTLISTCOUNT} digests, nothing to delete${NC}"
    continue
  fi

  # Filter the ordered list to remove the most recent 3
  DIGESTLISTTOREMOVE=$(echo "${DIGESTLIST}" | head -n -${IMAGES_TO_KEEP})
  DIGESTLISTTOREMOVECOUNT=$(echo "${DIGESTLISTTOREMOVE}" | wc -l)

  echo -e "${YELL}Found ${DIGESTLISTCOUNT} digests, ${DIGESTLISTTOREMOVECOUNT} to delete${NC}"

  # Do deletion or say nothing to do
  if [ "${DIGESTLISTTOREMOVECOUNT}" -gt "0" ]; then
    echo -e "${YELL}Removing ${DIGESTLISTTOREMOVECOUNT} digests${NC}"
    while IFS= read -r LINE; do
      LINE=$(echo $LINE|tr -d '\r')
        gcloud container images delete ${IMAGENAME}@${LINE} --force-delete-tags --quiet
    done <<< "${DIGESTLISTTOREMOVE}"
  else
    echo -e "${YELL}No digests to remove${NC}"
  fi
done <<< "${IMAGELIST}"
