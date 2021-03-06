---
date: "2016-07-03T04:02:20Z"
title: "Audit Logging Basics"
description: "Learn the basic ideas of how the Replicated Audit Log works and how to use it"
weight: "1702"
categories: [ "Audit Logging Basics" ]
index: ["docs/audit-log", "docs"]
icon: "replicatedAuditLog"
gradient: "console"
hideFromList: true
---

An audit log is a centralized stream of all user activity in an application.

An audit log event is a single line that represents an [action](/docs/audit-log/how-to/actions) that an [actor](/docs/audit-log/how-to/actors) took, most often on a [target](/docs/audit-log/how-to/targets).

Sometimes it's easiest to think about this with a concrete example. Let's consider a multi-user, collaborative spreadsheet application.

## Actors
An actor in the spreadsheet application is any authenticated identity that's interacting with the spreadsheet. This includes the users who are logged in and editing, deleting, and creating new spreadsheets. It also includes any API tokens that are performing operations on the spreadsheets programatically.

## Actions
Actions are the events that the actors performed that should be audited. In the spreadsheet example application, some of the most obvious actions might include `sheet.create` and `sheet.delete`. Sometimes it's important to create new objects to wrap events. For example, if a user is editing a spreadsheet and the sheet saves every second, you don't want to create a `sheet.update` event each second. Wrap these events into a session and create a single `sheet.update` event for the entire edit session.

## Targets
Targets are the objects in a system that have an action taken on them. In the spreadsheet example application, the primary target is the sheets themselves. But there are additional, less obvious targets. If the sheet application has implemented it's own authentication system, another target is the user accounts. For example, when a user changes their password, it should create an audit event for `password.update`.

