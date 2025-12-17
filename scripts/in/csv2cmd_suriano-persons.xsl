<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:csv="https://di.huc.knaw.nl/ns/csv"
    exclude-result-prefixes="xs math csv"
    version="3.0">
    
    <xsl:import href="csv2cmd.xsl"/>
    
    <xsl:param name="csv" select="'persons-suriano-20251217.csv'"/>    
    <xsl:param name="user" select="'liliana'"/>
    <xsl:param name="out" select="'./output'"/>
    
    <xsl:template name="main">
        <xsl:for-each select="csv:getCSV($csv)//r">
            <xsl:variable name="r" select="."/>
            <xsl:result-document href="{$out}/record-{number($r/@l) - 1}.xml" expand-text="yes">
                <cmd:CMD xmlns:cmd="http://www.clarin.eu/cmd/1"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.clarin.eu/cmd/1 https://infra.clarin.eu/CMDI/1.x/xsd/cmd-envelop.xsd http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1761816151556 http://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/1.2/profiles/clarin.eu:cr1:p_1761816151556/xsd"
                    CMDVersion="1.2">
                    <cmd:Header>
                        <cmd:MdCreator>{$user}</cmd:MdCreator>
                        <cmd:MdCreationDate>
                            <xsl:value-of select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                        </cmd:MdCreationDate>
                        <cmd:MdSelfLink>unl://{number($r/@l) - 1}</cmd:MdSelfLink>
                        <cmd:MdProfile>clarin.eu:cr1:p_1761816151556</cmd:MdProfile>
                        <cmd:MdCollectionDisplayName/>
                    </cmd:Header>
                    <cmd:Resources>
                        <cmd:ResourceProxyList/>
                        <cmd:JournalFileProxyList/>
                        <cmd:ResourceRelationList/>
                        <cmd:IsPartOfList/>
                    </cmd:Resources>
                    <cmd:Components>
                        <cmdp:Person xmlns:cmdp="http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1758888743558">
                            <cmdp:ResourceBasicMetadata>
                                <cmdp:name xml:lang="en">{normalize-space($r/c[@n='person'])}</cmdp:name>
                            </cmdp:ResourceBasicMetadata>
                            <cmdp:Identifier>
                                <cmdp:identifierLabel>{normalize-space($r/c[@n='local-id'])}</cmdp:identifierLabel>
                            </cmdp:Identifier>
                            <cmdp:Identifier>
                                <cmdp:identifierUrl>{normalize-space($r/c[@n='wikidata-uri'])}</cmdp:identifierUrl>
                            </cmdp:Identifier>
                            <cmdp:PersonName>
                                <cmdp:fullName>{normalize-space($r/c[@n='PRIMARY NAME'])}</cmdp:fullName>
                            </cmdp:PersonName>
                            <cmdp:PersonData>
                                <cmdp:BirthDate>
                                    <cmdp:DateReconstruction>
                                        <cmdp:dateStart>{normalize-space($r/c[@n='BIRTH YEAR'])}</cmdp:dateStart>
                                        <cmdp:Confidence>
                                            <cmdp:confidenceValue>{normalize-space($r/c[@n='birth-date-certainty'])}</cmdp:confidenceValue>
                                        </cmdp:Confidence>                                        
                                    </cmdp:DateReconstruction>
                                </cmdp:BirthDate>
                                <cmdp:DeathDate>
                                    <cmdp:DateReconstruction>
                                        <cmdp:dateStart>{normalize-space($r/c[@n='DEATH YEAR'])}</cmdp:dateStart>
                                        <cmdp:Confidence>
                                            <cmdp:confidenceValue>{normalize-space($r/c[@n='death-date-certainty'])}</cmdp:confidenceValue>
                                        </cmdp:Confidence>
                                    </cmdp:DateReconstruction>                                        
                                </cmdp:DeathDate>                                
                            </cmdp:PersonData>                            
                        </cmdp:Person>
                    </cmd:Components>
                </cmd:CMD>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>