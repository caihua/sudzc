<?xml version="1.0" encoding="UTF-8" ?>
<!--
	Converts the WSDL file to Objective-C for use in Cocoa applications.
-->
<xsl:stylesheet version="1.0"
	xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"
	xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/08/addressing"
	xmlns:wsap="http://schemas.xmlsoap.org/ws/2004/08/addressing/policy"
	xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy" 
	xmlns:msc="http://schemas.microsoft.com/ws/2005/12/wsdl/contract"
	xmlns:wsaw="http://www.w3.org/2006/05/addressing/wsdl"
	xmlns:soap12="http://schemas.xmlsoap.org/wsdl/soap12/"
	xmlns:wsa10="http://www.w3.org/2005/08/addressing"
	xmlns:wsam="http://www.w3.org/2007/05/addressing/metadata"
	xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
	xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
	xmlns:s="http://www.w3.org/2001/XMLSchema"
	xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/"
	xmlns:tns="http://epm.aholdusa.com/webservices/"
	xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/"
	xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output version="1.0" encoding="iso-8859-1" method="xml" omit-xml-declaration="no" indent="yes"/>
	<xsl:variable name="templateName">ObjCARC</xsl:variable>
	<xsl:include href="ObjCARCCommon.xslt"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- MAIN TEMPLATE FOR ALL DEFINITIONS -->
	<xsl:template match="wsdl:definitions">
		<package class="{$shortns}{$serviceName}">
			<xsl:attribute name="name"><xsl:value-of select="$serviceName"/>.iPhone</xsl:attribute>
			<folder copy="ObjCARC/Source"/>
			<include copy="ObjCARC/HOWTO.rtf"/>
			<include copy="ObjCARC/README.rtf"/>
			<file>
				<xsl:attribute name="filename"><xsl:value-of select="$shortns"/><xsl:value-of select="$serviceName"/>.h</xsl:attribute>/*
	<xsl:value-of select="$shortns"/><xsl:value-of select="$serviceName"/>.h
	The interface definition of classes and methods for the <xsl:value-of select="$serviceName"/> web service.
	Generated by SudzC.com
*/
				<xsl:call-template name="imports"/>
				<xsl:apply-templates select="wsdl:documentation"/>
/* Add class references */
				<xsl:apply-templates select="/wsdl:definitions/wsdl:types/s:schema/s:complexType[@name]" mode="class_reference">
					<xsl:sort select="count(descendant::s:element[substring-before(@type, ':') != 's'])"/>
				</xsl:apply-templates>

/* Interfaces for complex objects */
				<xsl:apply-templates select="/wsdl:definitions/wsdl:types/s:schema/s:complexType[@name]" mode="interface">
					<xsl:sort select="position()" order="descending"/>
				</xsl:apply-templates>

/* Interface for the service */
				<xsl:call-template name="createInterface"><xsl:with-param name="service" select="wsdl:service"/></xsl:call-template>
			</file>


			<file>
				<xsl:attribute name="filename"><xsl:value-of select="$shortns"/><xsl:value-of select="$serviceName"/>.m</xsl:attribute>/*
	<xsl:value-of select="$shortns"/><xsl:value-of select="$serviceName"/>.m
	The implementation classes and methods for the <xsl:value-of select="$serviceName"/> web service.
	Generated by SudzC.com
*/
				<xsl:call-template name="imports"/>
#import "<xsl:value-of select="$shortns"/><xsl:value-of select="$serviceName"/>.h"

/* Implementation for complex objects */
				<xsl:apply-templates select="/wsdl:definitions/wsdl:types/s:schema/s:complexType[@name]" mode="implementation">
					<xsl:sort select="position()" order="descending"/>
				</xsl:apply-templates>

/* Implementation of the service */
				<xsl:call-template name="createImplementation"><xsl:with-param name="service" select="wsdl:service"/></xsl:call-template>
			</file>
			<xsl:apply-templates/>
		</package>
	</xsl:template>

</xsl:stylesheet>
