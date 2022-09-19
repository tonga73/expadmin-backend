import { Injectable } from '@nestjs/common';
import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';

import { Record, Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class RecordsService {
  constructor(private prisma: PrismaService) {}

  create(data: Prisma.RecordCreateInput): Promise<Record> {
    return this.prisma.record.create({
      data,
    });
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.RecordWhereUniqueInput;
    where?: Prisma.RecordWhereInput;
    orderBy?: Prisma.RecordOrderByWithRelationInput;
  }): Promise<Record[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.record.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  findOne(
    recordWhereUniqueInput: Prisma.RecordWhereUniqueInput,
  ): Promise<Record | null> {
    return this.prisma.record.findUnique({
      where: recordWhereUniqueInput,
      include: {
        office: true,
        notes: true,
      },
    });
  }

  update(id: number, updateRecordDto: UpdateRecordDto): Promise<Record> {
    return this.prisma.record.update({
      data: updateRecordDto,
      where: { id },
    });
  }

  remove(where: Prisma.RecordWhereUniqueInput): Promise<Record> {
    return this.prisma.record.delete({
      where,
    });
  }
}
