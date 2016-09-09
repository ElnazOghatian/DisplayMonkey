/*!
* DisplayMonkey source file
* http://displaymonkey.org
*
* Copyright (c) 2015 Fuel9 LLC and contributors
*
* Released under the MIT license:
* http://opensource.org/licenses/MIT
*/

use DisplayMonkey	-- TODO: change if DisplayMonkey database name is different
GO

-- changes since v1.1
if not exists(select 1 from sys.columns where object_id=object_id('Outlook','U') and name='Privacy') begin
	alter table dbo.Outlook add
		Privacy int NOT NULL constraint DF_Outlook_Privacy default (0)
end
GO

-- changes since v1.2
update Template set html='
<div class="outlook">
	<div class="progress">
		<img src="files/world.gif" />
	</div>
	<div class="summary">
		<div class="mailbox"></div>
		<div class="current event"></div>
		<div class="current status"></div>
	</div>
	<div class="events">
		<table>
			<tr>
				<th class="label subject"></th>
				<th class="label starts"></th>
				<th class="label ends"></th>
				<th class="label duration"></th>
				<th class="label showAs"></th>
				<th class="label sensitivity"></th>
			</tr>
			<tr class="item">
				<td class="subject"></td>
				<td class="starts"></td>
				<td class="ends"></td>
				<td class="duration"></td>
				<td class="showAs"></td>
				<td class="sensitivity"></td>
			</tr>
		</table>
	</div>
	<div class="actions">
		<div class="title">Quick book</div>
		<div class="message"></div>
		<div class="controls">
			<input type="button" class="book" data-minutes="15" value="0:15" />
			<input type="button" class="book" data-minutes="30" value="0:30" />
			<input type="button" class="book" data-minutes="60" value="1:00" />
			<input type="button" class="book" />
		</div>
	</div>
</div>
'
where FrameType=4 and Name='default'
;

ALTER TABLE dbo.Outlook ADD
	AllowReserve bit NOT NULL CONSTRAINT DF_Outlook_AllowReserve DEFAULT 0
;

ALTER TABLE dbo.Outlook ADD
	ShowAsFlags int NOT NULL CONSTRAINT DF_Outlook_ShowAsFlags DEFAULT -1
;

GO