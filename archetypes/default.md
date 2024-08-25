---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: {{ .Date }}
description: {{ .Page.Summary }}
draft: true
---