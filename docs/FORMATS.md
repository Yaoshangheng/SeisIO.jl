# **Format Support**
| Format          | Read          | Write        | Fmt           | Notes       |
|:-----           |:-----         | :-----       |:-----         |:-----       |
| AH-1            | read_data     |              | ah1           |             |
| AH-2            | read_data     |              | ah2           |             |
| ASDF event      | read_asdf_evt | write_hdf5   | asdf          | w           |
| ASDF timeseries | read_hdf5     | write_hdf5   | asdf          | w           |
| Bottle          | read_data     |              | bottle        |             |
| Dataless SEED   | read_meta     |              | dataless      |             |
| GeoCSV slist    | read_data     |              | geocsv.slist  |             |
| GeoCSV tspair   | read_data     |              | geocsv        |             |
| Lennartz ASCII  | read_data     |              | lennartz      |             |
| Mini-SEED       | read_data     |              | mseed         | o           |
| PASSCAL SEG Y   | read_data     |              | passcal       |             |
| QuakeML         | read_qml      | write_qml    |               |             |
| RESP            | read_meta     |              | resp          |             |
| SAC polezero    | read_meta     |              | sacpz         |             |
| SAC timeseries  | read_data     | writesac     | sac           |             |
| SEG Y           | read_data     | writesacpz   | segy          | i           |
| SeisIO          | rseis         | wseis        |               |             |
| SLIST           | read_data     |              | slist         |             |
| SUDS event      | read_quake    |              | suds          | o           |
| SUDS timeseries | read_data     |              | suds          | o           |
| StationXML      | read_meta     | write_sxml   | sxml          |             |
| UW event        | read_quake    |              | uw            |             |
| UW timeseries   | read_data     |              | uw            |             |
| Win32           | read_data     |              | win32         |             |

## Column Guide
* **Format** is the most common abbreviated name for the data format
* **Read** is the read command
  + Most commands have two versions: in-place and out-of-place.
  + The out-of-place command is given above and creates a new structure.
  + The in-place command is the command in the column plus "!" (like "read_data!"); it modifies an existing data structure.
  * **Write** is the write command for formats with write support.
* **Fmt** is the format string passed to the read command
  + This is always the first ASCII string in the command
  + Example: *read_meta!(S, "sacpz", "tmp.sac.pz")*

## Notes Guide
* **i**: incomplete
  + SEG Y rev 2 read support is NYI; send us test files if you need it!
* **o**: out-of-scope blockettes/structures are skipped
* **w**: write_hdf5 uses fmt as a keyword that defaults to "asdf"; this will become more relevant when support expands to other hdf5 (sub)formats