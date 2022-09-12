import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Record, Prisma } from '@prisma/client';
import { UpdateRecordDto } from './dto/update-record.dto';

@Injectable()
export class RecordService {
  constructor(private prisma: PrismaService) {}

  async record(
    recordWhereUniqueInput: Prisma.RecordWhereUniqueInput,
  ): Promise<Record | null> {
    return this.prisma.record.findUnique({
      where: recordWhereUniqueInput,
      include: {
        tracings: true,
        district: true,
      },
    });
  }

  async records(params: {
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

  async createRecord(data: Prisma.RecordCreateInput): Promise<Record> {
    return this.prisma.record.create({
      data,
    });
  }

  async updateRecord(
    id: number,
    updateRecordDto: UpdateRecordDto,
  ): Promise<Record> {
    return this.prisma.record.update({
      data: updateRecordDto,
      where: { id },
    });
  }

  async deleteRecord(where: Prisma.RecordWhereUniqueInput): Promise<Record> {
    return this.prisma.record.delete({
      where,
    });
  }
}
