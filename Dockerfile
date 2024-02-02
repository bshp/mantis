# Ocie Version, e.g 22.04 unquoted
ARG OCIE_VERSION
    
FROM bshp/ocie:${OCIE_VERSION}
    
# Ocie
ENV OCIE_CONFIG=/etc/postfix \
    APP_TYPE="postfix"
    
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
