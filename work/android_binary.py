"""Readers for the chunk and string table formats in Android binary XML."""

import struct


def chunks(data, start=8, end=None):
    end = len(data) if end is None else end
    while start < end:
        kind, header, length = struct.unpack_from('<HHI', data, start)
        assert header >= 8 and length >= header and start + length <= end
        yield start, kind, header, length
        start += length
    assert start == end


def string_pool(data, offset):
    _, header, _ = struct.unpack_from('<HHI', data, offset)
    count, _, flags, start = struct.unpack_from('<IIII', data, offset + 8)
    utf8 = bool(flags & 256)

    def length_at(pos):
        value = data[pos] if utf8 else struct.unpack_from('<H', data, pos)[0]
        pos += 1 if utf8 else 2
        mask = 128 if utf8 else 32768
        if value & mask:
            low = data[pos] if utf8 else struct.unpack_from('<H', data, pos)[0]
            value = ((value & (mask - 1)) << (8 if utf8 else 16)) | low
            pos += 1 if utf8 else 2
        return value, pos

    result = []
    for index in range(count):
        pos = offset + start + struct.unpack_from('<I', data, offset + header + 4 * index)[0]
        length, pos = length_at(pos)
        if utf8:
            length, pos = length_at(pos)
            result.append(data[pos:pos + length].decode('utf8'))
        else:
            result.append(data[pos:pos + length * 2].decode('utf-16le'))
    return result


