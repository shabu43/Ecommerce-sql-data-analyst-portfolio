USE `mavenfuzzyfactory`;

SELECT 
    ws.utm_source, 
    ws.utm_campaign, 
    ws.http_referer, 
    COUNT(*) AS sessions
FROM 
    website_sessions ws
GROUP BY 
    ws.utm_source, ws.utm_campaign, ws.http_referer
ORDER BY 
    sessions DESC;