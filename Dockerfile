# Ocie Version, e.g 22.04 unquoted
ARG VERSION
    
# Optional: Change Timezone
ARG TZ=America/North_Dakota/Center
    
FROM bshp/ocie:${VERSION}
    
LABEL org.opencontainers.image.authors="jason.everling@gmail.com"
    
ARG TZ
    
ENV APP_TYPE="postfix"
ENV OCIE_TYPES=${OCIE_TYPES}:/etc/postfix
    
RUN <<"EOD" bash
    set -eu;
    POSTFIX_HOME=/etc/postfix;
    mkdir -p $POSTFIX_HOME/include;
    # Add packages
    ocie --pkg "-add mailutils,postfix,postfix-pcre,procmail -upgrade";
    chown -R root:root $POSTFIX_HOME;
    chmod -R 0755 $POSTFIX_HOME;
    ocie --clean "-base";
EOD

COPY --chown=root:root --chmod=0755 ./src/etc/postfix/ ./etc/postfix/
    
CMD ["/bin/bash"]
