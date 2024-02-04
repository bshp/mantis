# Ocie Version, e.g 22.04 unquoted
ARG OCIE_VERSION
    
FROM bshp/ocie:${OCIE_VERSION}
    
# Ocie
ENV OCIE_CONFIG=/etc/postfix \
    APP_TYPE="postfix" \
    APP_GROUP="root" \
    APP_OWNER="root" \
    INTERNAL_DOMAIN="" \
    MY_NETWORKS="" \
    RELAY_HOST=""
    
RUN <<"EOD" bash
    set -eu;
    POSTFIX_HOME=/etc/postfix;
    mkdir -p ${POSTFIX_HOME}/include;
    # Add packages
    ocie --pkg "-add mailutils,postfix,postfix-pcre,procmail -upgrade";
    chown -R ${APP_OWNER}:${APP_GROUP} ${POSTFIX_HOME};
    chmod -R 0755 ${POSTFIX_HOME};
    ocie --clean "-base";
EOD
    
COPY --chown=root:root --chmod=0755 ./src/etc/postfix/ ./etc/postfix/
    
EXPOSE 25
    
CMD ["/bin/bash"]
