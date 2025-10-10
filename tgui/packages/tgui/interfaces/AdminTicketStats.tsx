import { useCallback, useMemo, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Icon,
  Input,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { LoadingScreen } from './common/LoadingScreen';

type Data = {
  current_year: number;
  current_month: number;
  current_date: string;
  default_start_date: string;
  default_end_date: string;
  available_columns: ColumnOption[];
  grouping_options: GroupOption[];
  admin_list: string[];
  loading: BooleanLike;
  stats_data: StatsRow[];
  error_message: string;
};

type ColumnOption = {
  key: string;
  name: string;
};

type GroupOption = {
  key: string;
  name: string;
};

type StatsRow = {
  admin_name: string;
  admin_rank?: string;
  period_group?: string;
  Total_tickets?: number;
  Ticket_replies?: number;
  Rejected_count?: number;
  Resolved_count?: number;
  Closed_count?: number;
  IC_Issue_count?: number;
  Interaction_count?: number;
};

const DatePicker = ({ value, onChange, label }) => {
  const [showCalendar, setShowCalendar] = useState(false);
  const [tempDate, setTempDate] = useState(value);

  const currentDate = new Date();
  const [year, month, day] = value.split('-').map(Number);

  const yearOptions = Array.from({ length: 10 }, (_, i) => {
    const yearValue = currentDate.getFullYear() - 5 + i;
    return { value: yearValue.toString(), displayText: yearValue.toString() };
  });

  const monthOptions = Array.from({ length: 12 }, (_, i) => {
    const monthValue = (i + 1).toString().padStart(2, '0');
    const monthName = new Date(0, i).toLocaleString('en-US', {
      month: 'long',
    });
    return { value: monthValue, displayText: monthName };
  });

  const getDaysInMonth = (year: number, month: number) =>
    new Date(year, month, 0).getDate();

  const dayOptions = Array.from(
    { length: getDaysInMonth(year, month) },
    (_, i) => {
      const dayValue = (i + 1).toString().padStart(2, '0');
      return { value: dayValue, displayText: dayValue };
    },
  );

  const handleDateChange = () => {
    onChange(tempDate);
    setShowCalendar(false);
  };

  const formatDateForInput = (dateStr: string) => {
    const [y, m, d] = dateStr.split('-');
    return `${d.padStart(2, '0')}.${m.padStart(2, '0')}.${y}`;
  };

  return (
    <Box position="relative">
      <Box style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>
        <Input
          placeholder="DD.MM.YYYY"
          value={formatDateForInput(value)}
          disabled
          style={{ flex: 1 }}
        />
        <Button
          icon="calendar"
          onClick={() => setShowCalendar(!showCalendar)}
          tooltip="Select date"
          color={showCalendar ? 'good' : 'default'}
        />
      </Box>
      {showCalendar && (
        <Box
          position="absolute"
          top="100%"
          left="0"
          right="0"
          backgroundColor="rgba(16, 16, 16, 0.95)"
          p={3}
          style={{
            zIndex: 1000,
            boxShadow: '0 4px 12px rgba(0,0,0,0.5)',
            minWidth: '280px',
            border: '2px solid #4a90e2',
            borderRadius: '6px',
          }}
        >
          <Stack vertical>
            <Stack.Item>
              <Box
                fontSize="14px"
                fontWeight="bold"
                mb={1}
                textAlign="center"
                color="good"
              >
                Select Date
              </Box>
              <LabeledList>
                <LabeledList.Item label="Year">
                  <Dropdown
                    selected={tempDate.split('-')[0]}
                    options={yearOptions}
                    onSelected={(value) => {
                      const [, m, d] = tempDate.split('-');
                      setTempDate(`${value}-${m}-${d}`);
                    }}
                    width="100%"
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Month">
                  <Dropdown
                    selected={tempDate.split('-')[1]}
                    options={monthOptions}
                    onSelected={(value) => {
                      const [y, , d] = tempDate.split('-');
                      setTempDate(`${y}-${value}-${d}`);
                    }}
                    width="100%"
                  />
                </LabeledList.Item>
                <LabeledList.Item label="Day">
                  <Dropdown
                    selected={tempDate.split('-')[2]}
                    options={dayOptions}
                    onSelected={(value) => {
                      const [y, m] = tempDate.split('-');
                      setTempDate(`${y}-${m}-${value}`);
                    }}
                    width="100%"
                  />
                </LabeledList.Item>
              </LabeledList>
            </Stack.Item>
            <Stack.Item>
              <Stack>
                <Stack.Item grow>
                  <Button
                    fluid
                    content="Apply"
                    color="good"
                    onClick={handleDateChange}
                  />
                </Stack.Item>
                <Stack.Item grow>
                  <Button
                    fluid
                    content="Cancel"
                    color="bad"
                    onClick={() => {
                      setTempDate(value);
                      setShowCalendar(false);
                    }}
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Box>
      )}
    </Box>
  );
};

const getValueColor = (value: number | string) => {
  const numValue =
    typeof value === 'string' ? parseInt(value, 10) || 0 : value || 0;
  if (numValue === 0) return 'bad';
  if (numValue <= 20) return 'average';
  if (numValue >= 50) return 'good';
  return 'default';
};

export const AdminTicketStats = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    current_year,
    current_month,
    current_date,
    default_start_date,
    default_end_date,
    available_columns = [],
    grouping_options = [],
    admin_list = [],
    loading,
    stats_data = [],
    error_message,
  } = data;

  const [startDate, setStartDate] = useState(
    default_start_date || current_date || '',
  );
  const [endDate, setEndDate] = useState(
    default_end_date || current_date || '',
  );
  const [selectedAdmin, setSelectedAdmin] = useState('All');
  const [groupBy, setGroupBy] = useState('none');
  const [selectedColumns, setSelectedColumns] = useState(() => {
    const initial = {};
    if (available_columns && available_columns.length > 0) {
      available_columns.forEach((col) => {
        initial[col.key] = true;
      });
    }
    return initial;
  });
  const [sortColumn, setSortColumn] = useState('');
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');
  const [zeroFilter, setZeroFilter] = useState<
    'all' | 'with_activity' | 'zero_only'
  >('with_activity');

  useMemo(() => {
    if (available_columns && available_columns.length > 0) {
      setSelectedColumns((prev) => {
        const updated = {};
        available_columns.forEach((col) => {
          updated[col.key] = prev[col.key] !== undefined ? prev[col.key] : true;
        });
        return updated;
      });
    }
  }, [available_columns]);

  const handleColumnToggle = useCallback((columnKey: string) => {
    setSelectedColumns((prev) => ({
      ...prev,
      [columnKey]: !prev[columnKey],
    }));
  }, []);

  const handleSort = useCallback((column: string) => {
    setSortColumn((prevColumn) => {
      if (prevColumn === column) {
        setSortOrder((prevOrder) => (prevOrder === 'asc' ? 'desc' : 'asc'));
        return column;
      } else {
        setSortOrder('desc');
        return column;
      }
    });
  }, []);

  const handleFetchStats = useCallback(() => {
    if (loading) return;

    const selectedCols = Object.keys(selectedColumns).filter(
      (key) => selectedColumns[key],
    );

    if (selectedCols.length === 0) {
      return;
    }

    act('fetch_stats', {
      start_date: startDate,
      end_date: endDate,
      admin_filter: selectedAdmin === 'All' ? '' : selectedAdmin,
      grouping: groupBy,
      selected_columns: selectedCols,
    });
  }, [
    act,
    startDate,
    endDate,
    selectedAdmin,
    groupBy,
    selectedColumns,
    loading,
  ]);

  const getDaysInMonth = (year: number, month: number) => {
    return new Date(year, month, 0).getDate();
  };

  const handlePreviousMonth = useCallback(() => {
    const [year, month] = startDate.split('-').map(Number);
    const prevMonth = month === 1 ? 12 : month - 1;
    const prevYear = month === 1 ? year - 1 : year;
    const daysInMonth = getDaysInMonth(prevYear, prevMonth);

    const newStart = `${prevYear}-${prevMonth.toString().padStart(2, '0')}-01`;
    const newEnd = `${prevYear}-${prevMonth.toString().padStart(2, '0')}-${daysInMonth.toString().padStart(2, '0')}`;

    setStartDate(newStart);
    setEndDate(newEnd);
  }, [startDate]);

  const handleNextMonth = useCallback(() => {
    const [year, month] = startDate.split('-').map(Number);
    const nextMonth = month === 12 ? 1 : month + 1;
    const nextYear = month === 12 ? year + 1 : year;
    const daysInMonth = getDaysInMonth(nextYear, nextMonth);

    const newStart = `${nextYear}-${nextMonth.toString().padStart(2, '0')}-01`;
    const newEnd = `${nextYear}-${nextMonth.toString().padStart(2, '0')}-${daysInMonth.toString().padStart(2, '0')}`;

    setStartDate(newStart);
    setEndDate(newEnd);
  }, [startDate]);

  const adminOptions = useMemo(() => {
    const options = [{ value: 'All', displayText: 'All Admins' }];
    if (admin_list && admin_list.length > 0) {
      admin_list.forEach((admin) => {
        options.push({ value: admin, displayText: admin });
      });
    }
    return options;
  }, [admin_list]);

  const groupingOptions = useMemo(() => {
    if (grouping_options && grouping_options.length > 0) {
      return grouping_options.map((opt) => ({
        value: opt.key,
        displayText: opt.name,
      }));
    }
    return [{ value: 'none', displayText: 'No Grouping' }];
  }, [grouping_options]);

  const filteredAndSortedData = useMemo(() => {
    if (!stats_data || stats_data.length === 0) return [];

    let filtered = [...stats_data];

    // Apply zero filter
    if (zeroFilter !== 'all') {
      filtered = filtered.filter((row) => {
        const selectedCols = Object.keys(selectedColumns).filter(
          (key) => selectedColumns[key],
        );
        const totalActivity = selectedCols.reduce((sum, col) => {
          return sum + (row[col] || 0);
        }, 0);

        if (zeroFilter === 'with_activity') {
          return totalActivity > 0;
        } else if (zeroFilter === 'zero_only') {
          return totalActivity === 0;
        }
        return true;
      });
    }

    if (sortColumn) {
      filtered.sort((a, b) => {
        const aVal = a[sortColumn];
        const bVal = b[sortColumn];

        const aNum = parseFloat(aVal);
        const bNum = parseFloat(bVal);

        let comparison = 0;
        if (!isNaN(aNum) && !isNaN(bNum)) {
          comparison = aNum - bNum;
        } else {
          comparison = String(aVal).localeCompare(String(bVal));
        }

        return sortOrder === 'asc' ? comparison : -comparison;
      });
    }

    return filtered;
  }, [stats_data, sortColumn, sortOrder, zeroFilter, selectedColumns]);

  const visibleColumns = useMemo(() => {
    if (!available_columns || available_columns.length === 0) return [];
    return available_columns.filter((col) => selectedColumns[col.key]);
  }, [available_columns, selectedColumns]);

  const displayError = error_message && error_message.trim() !== '';
  const hasData = stats_data && stats_data.length > 0;
  const hasSelectedColumns = Object.values(selectedColumns).some(Boolean);

  if (loading) {
    return (
      <Window
        title="Admin Ticket Statistics"
        width={1200}
        height={800}
        theme="admin"
      >
        <Window.Content>
          <LoadingScreen label="Generating ticket statistics..." />
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window
      title="Admin Ticket Statistics"
      width={1200}
      height={800}
      theme="admin"
    >
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section
              title="Filters & Settings"
              buttons={
                <Button
                  icon="chart-bar"
                  content="Generate Report"
                  color="good"
                  onClick={handleFetchStats}
                  disabled={loading || !hasSelectedColumns}
                  tooltip={
                    !hasSelectedColumns
                      ? 'Please select at least one column'
                      : ''
                  }
                />
              }
            >
              <Stack>
                <Stack.Item basis="50%">
                  <LabeledList>
                    <LabeledList.Item label="Start Date">
                      <DatePicker
                        value={startDate}
                        onChange={setStartDate}
                        label="Start Date"
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="End Date">
                      <DatePicker
                        value={endDate}
                        onChange={setEndDate}
                        label="End Date"
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="Quick Navigation">
                      <Button
                        icon="chevron-left"
                        content="Previous Month"
                        onClick={handlePreviousMonth}
                        tooltip="Set dates to previous month"
                        mr={1}
                      />
                      <Button
                        icon="chevron-right"
                        content="Next Month"
                        onClick={handleNextMonth}
                        tooltip="Set dates to next month"
                      />
                    </LabeledList.Item>
                  </LabeledList>
                </Stack.Item>
                <Stack.Item basis="50%">
                  <LabeledList>
                    <LabeledList.Item label="Admin">
                      <Dropdown
                        selected={selectedAdmin}
                        options={adminOptions}
                        onSelected={setSelectedAdmin}
                        width="100%"
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="Group By">
                      <Dropdown
                        selected={groupBy}
                        options={groupingOptions}
                        onSelected={setGroupBy}
                        width="100%"
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="Activity Filter">
                      <Button.Checkbox
                        checked={zeroFilter === 'all'}
                        onClick={() =>
                          setZeroFilter(
                            zeroFilter === 'all' ? 'with_activity' : 'all',
                          )
                        }
                        content="Show All"
                        tooltip="Show all admins regardless of activity"
                      />
                      <Button.Checkbox
                        checked={zeroFilter === 'with_activity'}
                        onClick={() =>
                          setZeroFilter(
                            zeroFilter === 'with_activity'
                              ? 'all'
                              : 'with_activity',
                          )
                        }
                        content="With Activity"
                        tooltip="Show only admins with ticket activity"
                        ml={1}
                      />
                      <Button.Checkbox
                        checked={zeroFilter === 'zero_only'}
                        onClick={() =>
                          setZeroFilter(
                            zeroFilter === 'zero_only' ? 'all' : 'zero_only',
                          )
                        }
                        content="Zero Only"
                        tooltip="Show only admins with no ticket activity"
                        ml={1}
                      />
                    </LabeledList.Item>
                  </LabeledList>
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>

          <Stack.Item>
            <Section title="Display Columns">
              {available_columns && available_columns.length > 0 ? (
                <Box
                  style={{
                    display: 'flex',
                    flexWrap: 'wrap',
                    gap: '8px',
                    alignItems: 'center',
                  }}
                >
                  {available_columns.map((column) => (
                    <Button.Checkbox
                      key={column.key}
                      checked={selectedColumns[column.key] || false}
                      onClick={() => handleColumnToggle(column.key)}
                      style={{ minWidth: 'fit-content', marginBottom: '4px' }}
                    >
                      {column.name}
                    </Button.Checkbox>
                  ))}
                </Box>
              ) : (
                <Box color="average">Loading columns...</Box>
              )}
            </Section>
          </Stack.Item>

          <Stack.Item grow>
            {displayError ? (
              <Section fill>
                <NoticeBox color="bad">{error_message}</NoticeBox>
              </Section>
            ) : hasData ? (
              <Section
                fill
                scrollable
                title={`Statistics (${filteredAndSortedData.length} rows)`}
              >
                <Table>
                  <Table.Row header>
                    {/* Period Group column (only when grouping is enabled) */}
                    {groupBy !== 'none' && (
                      <Table.Cell
                        style={{ cursor: 'pointer', userSelect: 'none' }}
                        onClick={() => handleSort('period_group')}
                      >
                        <Stack align="center">
                          <Stack.Item>Period</Stack.Item>
                          <Stack.Item>
                            {sortColumn === 'period_group' && (
                              <Icon
                                name={
                                  sortOrder === 'asc'
                                    ? 'sort-amount-up'
                                    : 'sort-amount-down'
                                }
                                size={0.8}
                              />
                            )}
                          </Stack.Item>
                        </Stack>
                      </Table.Cell>
                    )}

                    {/* Admin Name column */}
                    <Table.Cell
                      style={{ cursor: 'pointer', userSelect: 'none' }}
                      onClick={() => handleSort('admin_name')}
                    >
                      <Stack align="center">
                        <Stack.Item>Admin Name</Stack.Item>
                        <Stack.Item>
                          {sortColumn === 'admin_name' && (
                            <Icon
                              name={
                                sortOrder === 'asc'
                                  ? 'sort-amount-up'
                                  : 'sort-amount-down'
                              }
                              size={0.8}
                            />
                          )}
                        </Stack.Item>
                      </Stack>
                    </Table.Cell>

                    {/* Admin Rank column */}
                    <Table.Cell
                      style={{ cursor: 'pointer', userSelect: 'none' }}
                      onClick={() => handleSort('admin_rank')}
                    >
                      <Stack align="center">
                        <Stack.Item>Rank</Stack.Item>
                        <Stack.Item>
                          {sortColumn === 'admin_rank' && (
                            <Icon
                              name={
                                sortOrder === 'asc'
                                  ? 'sort-amount-up'
                                  : 'sort-amount-down'
                              }
                              size={0.8}
                            />
                          )}
                        </Stack.Item>
                      </Stack>
                    </Table.Cell>

                    {/* Selected data columns */}
                    {visibleColumns.map((column) => (
                      <Table.Cell
                        key={column.key}
                        style={{ cursor: 'pointer', userSelect: 'none' }}
                        onClick={() => handleSort(column.key)}
                      >
                        <Stack align="center">
                          <Stack.Item>{column.name}</Stack.Item>
                          <Stack.Item>
                            {sortColumn === column.key && (
                              <Icon
                                name={
                                  sortOrder === 'asc'
                                    ? 'sort-amount-up'
                                    : 'sort-amount-down'
                                }
                                size={0.8}
                              />
                            )}
                          </Stack.Item>
                        </Stack>
                      </Table.Cell>
                    ))}
                  </Table.Row>
                  {filteredAndSortedData.map((row, index) => (
                    <Table.Row
                      key={index}
                      className={index % 2 === 0 ? '' : 'candystripe'}
                    >
                      {/* Period Group cell */}
                      {groupBy !== 'none' && (
                        <Table.Cell>
                          <Box color="label">{row.period_group || 'N/A'}</Box>
                        </Table.Cell>
                      )}

                      {/* Admin Name cell */}
                      <Table.Cell>
                        <Box color="good" bold>
                          {row.admin_name}
                        </Box>
                      </Table.Cell>

                      {/* Admin Rank cell */}
                      <Table.Cell>
                        <Box color="label">{row.admin_rank || 'Unknown'}</Box>
                      </Table.Cell>

                      {/* Data cells with color coding */}
                      {visibleColumns.map((column) => {
                        const value = row[column.key] || 0;
                        return (
                          <Table.Cell key={column.key} textAlign="center">
                            <Box color={getValueColor(value)} bold>
                              {value}
                            </Box>
                          </Table.Cell>
                        );
                      })}
                    </Table.Row>
                  ))}
                </Table>
              </Section>
            ) : (
              <Section fill>
                <Box
                  textAlign="center"
                  color="average"
                  fontSize="1.2em"
                  style={{ marginTop: '100px' }}
                >
                  <Stack vertical>
                    <Stack.Item>📊 No data available</Stack.Item>
                    <Stack.Item>
                      Configure your filters and click &quot;Generate
                      Report&quot; to view statistics
                    </Stack.Item>
                  </Stack>
                </Box>
              </Section>
            )}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
